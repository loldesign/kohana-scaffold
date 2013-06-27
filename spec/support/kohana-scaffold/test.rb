module KohanaScaffold
  module Test
    extend self

    APPLICATION_NAME = "sample-app"

    def generate_app
      AppGenerator.new([APPLICATION_NAME], ["-p=#{test_path}", "-V"]).invoke_all
    end

    def destroy_app
      FileUtils.remove_dir(application_path)
    end

    def application_path
      File.join(test_path, APPLICATION_NAME)
    end

    def test_path
      File.expand_path("../../../tmp/", __FILE__)
    end
  end
end
