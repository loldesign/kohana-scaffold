module KohanaScaffold
  module Test
    extend self

    APPLICATION_NAME = "sample-app"

    class Regexp
      BASE_URL    = /\'base_url\' => \'\/#{APPLICATION_NAME}\/\',/
      COOKIE_SALT = /Cookie::\$salt = '[a-z0-9]{8}-[a-z0-9]{4}-[a-z0-9]{4}-[a-z0-9]{4}-[a-z0-9]{12}\';/

      def self.included_module(mod)
        /^[^\/\/*]*'#{mod}'\s+=>\s+MODPATH.\'#{mod}\',/
      end
    end

    def generate_app(options=[])
      AppGenerator.new([APPLICATION_NAME], app_generator_options+options).invoke_all
    end

    def destroy_app
      FileUtils.remove_dir(application_path)
    end

    def application_path
      File.join(test_path, APPLICATION_NAME)
    end

    def file_absolute_path(file)
      File.join(KohanaScaffold::Test.application_path, file)
    end

    private

    def app_generator_options
      ["-p=#{test_path}", "-V"]
    end

    def test_path
      File.expand_path("../../../tmp/", __FILE__)
    end
  end
end
