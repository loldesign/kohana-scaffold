shared_examples "a Kohana controller generator" do |name|
  DEFAULT_SKELETON = %W(
    application/classes/Controller/#{name.capitalize.pluralize}.php
    application/views/#{name.downcase}/index.php
    application/views/#{name.downcase}/show.php
  )

  before(:all) do
    KohanaScaffold::Test.generate_app
    KohanaScaffold::ScaffoldGenerator.start([name])
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
  end
end
