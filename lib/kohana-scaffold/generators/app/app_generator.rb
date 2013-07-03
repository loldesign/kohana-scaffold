require 'securerandom'

module KohanaScaffold
  class AppGenerator < Thor::Group
    include Thor::Actions

    MODULES = %w(
      auth
      cache
      codebench
      database
      image
      minion
      orm
      unittest
      userguide
    )

    argument :project_path

    class_option :public_path,
      default: '/Applications/MAMP/htdocs',
      aliases: '-p',
      desc: 'Define the Apache public directory. A symbolic link will be created here.'

    class_option :modules,
      default: [],
      type: :array,
      aliases: '-m',
      desc: 'Define what modules will be loaded'

    class_option :silent,
      type: :boolean,
      aliases: '-V',
      desc: 'Silent mode'

    class_option :with_db,
      type: :boolean,
      desc: 'Enable to configure the database'

    def initialize(args=[], options={}, config={})
      super(args, options, config)

      self.destination_root = project_path
      @project_name = project_path.split('/').last

      raise_module_error if has_invalid_modules?
    end

    def self.source_root
      File.join(File.dirname(__FILE__), 'templates')
    end

    def self.banner
      "kohana new #{self.arguments.map(&:usage).join(' ')} [options]"
    end

    def copy_kohana
      directory("kohana", ".", default_options)
    end

    def create_htaccess
      template("htaccess.erb", ".htaccess", default_options)
    end

    def create_cache_folder
      empty_directory("application/cache", default_options)
    end

    def create_bootstrap
      template("bootstrap.erb", "application/bootstrap.php", default_options)
    end

    def add_default_cookie_salt
      options = default_options.merge(
        {after: "I18n::lang('en-us');\n"}
      )

      cookie_salt = "Cookie::$salt = '#{SecureRandom.uuid}';"
      inject_into_file("application/bootstrap.php", cookie_salt, options)
    end

    def symbolic_link
      system("ln -s #{destination_root} #{@options[:public_path]}")
    end

    def config_database
      if @options[:with_db]
        host      = ask("MySql host: (default: localhost)")
        name      = ask("MySql database name: (default: #{@project_name})")
        username  = ask("MySql username: (default: root)")
        password  = ask("MySql password: (default: root)")

        @db_host      = host.blank? ? "localhost" : host
        @db_name      = name.blank? ? @project_name : name
        @db_username  = username.blank? ? "root" : username
        @db_password  = password.blank? ? "root" : password

        template("mysql.erb", "application/config/database.php", default_options)
      end
    end

    private

    def default_options
      @default_options ||= {verbose: @options[:silent].nil?}
    end

    def has_invalid_modules?
      @options[:modules].any? {|mod| !MODULES.include?(mod)}
    end

    def raise_module_error
      wrong_modules = (@options[:modules] - MODULES).join(", ")
      raise ArgumentError, "invalid modules names: #{wrong_modules}"
    end
  end
end
