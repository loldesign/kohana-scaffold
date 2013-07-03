shared_examples "a Kohana skeleton generator" do
  DEFAULT_SKELETON = %w(
    application
    application/bootstrap.php
    application/cache
    application/classes
    application/logs
    application/views
    modules
    system
    vendor
    .htaccess
    composer.json
    composer.lock
    composer.phar
    index.php
    install_.php
    LICENSE.md
    README.md
  )

  REMOVED_FILES = %w(
    example.htaccess
  )

  context 'skeleton' do
    before(:all) do
      KohanaScaffold::Test.generate_app
    end

    context 'needed files' do
      DEFAULT_SKELETON.each do |resource|
        it "checks if #{resource} is present" do
          resource.should be_present_in_kohana
        end
      end
    end

    context 'unused files' do
      REMOVED_FILES.each do |resource|
        it "checks if #{resource} is not present" do
          resource.should_not be_present_in_kohana
        end
      end
    end

    context 'basic file configuration' do
      context 'application/bootstrap.php' do
        subject do
          file = KohanaScaffold::Test.file_absolute_path("application/bootstrap.php")
          File.read(file)
        end

        it {should match(KohanaScaffold::Test::Regexp::BASE_URL)}
        it {should match(KohanaScaffold::Test::Regexp::COOKIE_SALT)}
        it {should match(KohanaScaffold::Test::Regexp::INDEX_FILE)}
      end
    end
  end

  context 'with database configuration' do
    before(:each, default_configs: true) do
      $stdin.stub(:gets).and_return("")
      KohanaScaffold::Test.generate_app(["--with-db"])
    end

    # MySql config: host, database_name, username, password
    before(:each, custom_configs: true) do
      $stdin.stub(:gets).and_return("127.0.0.1", "test-database", "toor", "1234")
      KohanaScaffold::Test.generate_app(["--with-db"])
    end

    context 'needed files' do
      let(:database_file) {'application/config/database.php'}
      it "checks if application/config/database.php is present", default_configs: true do
        database_file.should be_present_in_kohana
      end
    end

    context 'file configuration' do
      subject do
        file = KohanaScaffold::Test.file_absolute_path("application/config/database.php")
        File.read(file)
      end

      context 'default config' do
        it "should match default configurations", default_configs: true do
          should match(/\'hostname\'\s*=> \'localhost\',/)
          should match(/\'database\'\s*=> \'sample-app\',/)
          should match(/\'username\'\s*=> \'root\',/)
          should match(/\'password\'\s*=> \'root\',/)
        end
      end

      context 'custom config' do
        it "should match custom configurations", custom_configs: true do
          should match(/\'hostname\'\s*=> \'127.0.0.1\',/)
          should match(/\'database\'\s*=> \'test-database\',/)
          should match(/\'username\'\s*=> \'toor\',/)
          should match(/\'password\'\s*=> \'1234\',/)
        end
      end
    end
  end
end
