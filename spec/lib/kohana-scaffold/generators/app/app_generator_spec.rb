require 'spec_helper'

describe KohanaScaffold::AppGenerator do
  it_behaves_like "a Kohana skeleton generator"
  it_behaves_like "a mountable engine", "auth"
  it_behaves_like "a mountable engine", "cache"
  it_behaves_like "a mountable engine", "codebench"
  it_behaves_like "a mountable engine", "database"
  it_behaves_like "a mountable engine", "image"
  it_behaves_like "a mountable engine", "minion"
  it_behaves_like "a mountable engine", "orm"
  it_behaves_like "a mountable engine", "unittest"
  it_behaves_like "a mountable engine", "userguide"

  describe "options" do
    let(:options) {[]}
    let(:generator) {described_class.new(["sample-app"], options)}

    context 'public_path' do
      context 'default' do
        it {generator.options[:public_path].should == "/Applications/MAMP/htdocs"}
      end

      context 'custom' do
        let(:options) {["-p=/tmp"]}
        it {generator.options[:public_path].should == "/tmp"}
      end
    end

    context 'silent mode' do
      context 'default' do
        it {generator.options[:silent].should be_false}
      end

      context 'custom' do
        let(:options) {["-V"]}
        it {generator.options[:silent].should be_true}
      end
    end

    context 'modules' do
      context 'default' do
        it {generator.options[:modules].should be_empty}
      end

      context 'custom' do
        let(:options) {["-m=auth"]}
        it {generator.options[:modules].should == ["auth"]}
      end
    end

    context 'validate' do
      let(:options) {["-m=auth", "image", "orm", "wrong", "guard"]}

      it "raise a custom error with invalids modules" do
        expect {described_class.new(["sample-app"], options)}
          .to raise_error(ArgumentError, 'invalid modules names: wrong, guard')
      end
    end
  end
end
