shared_examples "a Kohana scaffold generator" do |name|
  DEFAULT_SKELETON = %W(
    application/classes/Controller/#{name.capitalize.pluralize}.php
    application/views/#{name.downcase}/index.php
    application/views/#{name.downcase}/show.php
  )

  before(:all) do
    KohanaScaffold::Test.generate_app
    KohanaScaffold::ScaffoldGenerator.start([name])
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

  context '#validate' do
    it "should prevent of to run scaffold command outside of project root" do
      Kernel.should_receive(:puts).with("To run kohana scaffold please go to the project root folder.")
      FileUtils.cd("/tmp")
      expect { KohanaScaffold::ScaffoldGenerator.start(["item"]) }.to raise_error SystemExit
    end
  end
end
