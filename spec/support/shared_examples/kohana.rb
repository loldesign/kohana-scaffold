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

  before(:all) do
    KohanaScaffold::Test.generate_app
  end

  after(:all) do
    KohanaScaffold::Test.destroy_app
  end

  context 'skeleton' do
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
