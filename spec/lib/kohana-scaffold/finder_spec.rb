require 'spec_helper'

describe KohanaScaffold::Finder do
  describe ".localize_command" do
    let(:action) {mock}
    before {described_class.should_receive(:runner_for).with("some action").and_return(action)}

    context "one arg" do
      before {action.should_receive(:start).with([])}
      it {described_class.localize_command(["some action"])}
    end

    context "more than one arg" do
      before {action.should_receive(:start).with(["some arg"])}
      it {described_class.localize_command(["some action", "some arg"])}
    end
  end

  describe 'banner message' do
    context 'AppGenerator' do
      let(:output) {capture(:stdout){described_class.localize_command(["new", "-h"])}}
      it {output.should match(/kohana new PROJECT_PATH \[options\]/)}
    end
  end

  describe ".runner_for" do
    subject do
      described_class.runner_for(action)
    end

    context 'new' do
      let(:action){"new"}
      it {should == KohanaScaffold::AppGenerator}
    end

    context 'help' do
      let(:action){"help"}
      it {should == KohanaScaffold::Help}
    end
  end
end
