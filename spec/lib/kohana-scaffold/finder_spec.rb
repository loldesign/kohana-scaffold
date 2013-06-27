require 'spec_helper'

describe KohanaScaffold::Finder do
  describe ".localize_command" do
    let(:action) {mock}
    before {described_class.should_receive(:runner_for).with("some action").and_return(action)}

    context "one arg" do
      before {action.should_receive(:run).with([])}
      it {described_class.localize_command(["some action"])}
    end

    context "more than one arg" do
      before {action.should_receive(:run).with(["some arg"])}
      it {described_class.localize_command(["some action", "some arg"])}
    end

    context "argument missing" do
      before do
        action.should_receive(:run).and_raise(Thor::RequiredArgumentMissingError)
        action.should_receive(:help)
      end

      it {described_class.localize_command(["some action"])}
    end
  end

  describe ".runner_for" do
    subject do
      described_class.runner_for(action)
    end

    context 'new' do
      let(:action){"new"}
      it {should be_a_kind_of(KohanaScaffold::Runner::New)}
    end

    context 'help' do
      let(:action){"help"}
      it {should be_a_kind_of(KohanaScaffold::Runner::Help)}
    end
  end
end
