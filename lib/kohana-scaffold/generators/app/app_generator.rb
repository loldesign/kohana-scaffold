require 'securerandom'

module KohanaScaffold
  class AppGenerator < Thor::Group
    include Thor::Actions

    argument :project_name

    class_option :public_path,
      default: '/Applications/MAMP/htdocs',
      aliases: '-p',
      desc: 'Define the Apache public directory'

    class_option :modules,
      default: [],
      type: :array,
      aliases: '-m',
      desc: 'Define what modules will be loaded'

    class_option :silent,
      type: :boolean,
      aliases: '-V',
      desc: 'Silent mode'

    def initialize(args=[], options={}, config={})
      super(args, options, config)
      self.destination_root = "#{@options[:public_path]}/"
    end

    def self.source_root
      File.join(File.dirname(__FILE__), 'templates')
    end

    def copy_kohana
      directory("kohana", project_name, default_options)
    end

    def create_cache_folder
      empty_directory("#{project_name}/application/cache", default_options)
    end

    def create_bootstrap
      template("bootstrap.erb", "#{project_name}/application/bootstrap.php", default_options)
    end

    def add_default_cookie_salt
      options = default_options.merge(
        {after: "I18n::lang('en-us');\n"}
      )

      cookie_salt = "Cookie::$salt = '#{SecureRandom.uuid}';"
      inject_into_file("#{project_name}/application/bootstrap.php", cookie_salt, options)
    end

    private

    def default_options
      @default_options ||= {verbose: @options[:silent].nil?}
    end
  end
end
