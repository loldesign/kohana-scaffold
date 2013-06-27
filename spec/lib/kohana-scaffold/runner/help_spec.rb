require 'spec_helper'

describe KohanaScaffold::Runner::Help do
  describe '.run' do
    context 'stdout' do
      it "should call Kernel.stdout" do
        Kernel.should_receive(:puts)
        described_class.run
      end
    end

    context 'the text message' do
      let(:output){`kohana help`}

      it {output.should match(/^Usage: kohana COMMAND \[ARGS\]/)}
      it {output.should match(/List of commands:/)}
      it {output.should match(/new+\s*Create a new Kohana application. Ex.: \"kohana new sample\" creates a new application on MAMP folder \(by default\)/)}
      it {output.should match(/help\s*Show this message/)}
      it {output.should match(/All commands can be run with -h for more information./)}
    end
  end
end
