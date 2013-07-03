shared_examples "a mountable engine" do |mod|
  before(:all) do
    KohanaScaffold::Test.generate_app(["-m=#{mod}"])
  end

  context "enable module #{mod}" do
    subject do
      file = KohanaScaffold::Test.file_absolute_path("application/bootstrap.php")
      File.read(file)
    end

    it {should match(KohanaScaffold::Test::Regexp.included_module(mod))}
  end
end
