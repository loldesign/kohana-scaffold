shared_examples "a Kohana scaffold generator with db" do |name, fields|
  SCAFFOLD_SKELETON = %W(
    application/classes/Controller/#{name.capitalize.pluralize}.php
    application/classes/Model/#{name.capitalize}.php
    application/views/#{name.downcase}/index.php
    application/views/#{name.downcase}/show.php
  )

  before(:all) do
    $stdin.stub(:gets).and_return("127.0.0.1", "test-database", "toor", "1234")
    KohanaScaffold::Test.generate_app(["--with-db", "-m=database", "orm"])
    KohanaScaffold::ScaffoldGenerator.start([name, fields])
  end

  context 'skeleton' do
    context 'needed files' do
      SCAFFOLD_SKELETON.each do |resource|
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
