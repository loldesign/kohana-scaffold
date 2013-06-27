require 'spec_helper'

describe KohanaScaffold::AppGenerator do
  it_behaves_like "a Kohana's project skeleton generator"

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
  end
end
