shared_examples "a Kohana's project skeleton generator" do
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
    composer.json
    composer.lock
    composer.phar
    example.htaccess
    index.php
    install_.php
    LICENSE.md
    README.md
  )

  before(:all) do
    KohanaScaffold::Test.generate_app
  end

  after(:all) do
    KohanaScaffold::Test.destroy_app
  end

  context 'skeleton' do
    it "checks if default files and folders are present" do
      DEFAULT_SKELETON.each do |resource|
        File.exists?(File.join(KohanaScaffold::Test.application_path, resource)).should be_true
      end
    end
  end

  context 'file configuration' do
    context 'application/bootstrap.php' do
      subject do
        file = KohanaScaffold::Test.file_absolute_path("application/bootstrap.php")
        File.read(file)
      end

      it {should match(KohanaScaffold::Test::Regexp::BASE_URL)}
      it {should match(KohanaScaffold::Test::Regexp::COOKIE_SALT)}
    end
  end
end
