require 'securerandom'

module KohanaScaffold
  class AppGenerator < Thor::Group
    include Thor::Actions

    argument :project_name

    class_option :public_path,
      default: '/Applications/MAMP/htdocs',
      aliases: '-p',
      desc: 'Define the Apache public directory'

    def initialize(args=[], options={}, config={})
      super(args, options, config)
      self.destination_root = "#{@options[:public_path]}/"
    end

    def self.source_root
      File.join(File.dirname(__FILE__), 'templates')
    end

    def copy_kohana
      directory("kohana", project_name)
    end

    def create_cache_folder
      empty_directory("#{project_name}/application/cache", verbose: false)
    end

    def create_bootstrap
      template("bootstrap.erb", "#{project_name}/application/bootstrap.php")
    end

    def add_default_cookie_salt
      cookie_salt = "Cookie::$salt = '#{SecureRandom.uuid}';"
      inject_into_file("#{project_name}/application/bootstrap.php", cookie_salt, after: "I18n::lang('en-us');\n")
    end
  end
end
