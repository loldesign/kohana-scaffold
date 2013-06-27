require 'spec_helper'

describe KohanaScaffold::Runner::New do
  describe '.run' do
    context 'stdout' do
      it "should call Kernel.stdout" do
        Kernel.should_receive(:puts)
        described_class.run(['-h'])
      end
    end

    context '-h option' do
      it "call the help method with args that include -h option" do
        described_class.should_receive(:help)
        described_class.run(['action', '-h', 'action'])
      end
    end

    context 'AppGenerator' do
      let(:generator){KohanaScaffold::AppGenerator}
      let(:app){mock(invoke_all: true)}

      it "call with project_name and a empty args" do
        generator.should_receive(:new).with(['sample'], []).and_return(app)
        described_class.run(['sample'])
      end

      it "call with project_name and some args" do
        generator.should_receive(:new).with(['sample'], ['-m auth']).and_return(app)
        described_class.run(['sample', '-m auth'])
      end
    end

    context 'the text message' do
      let(:output){`kohana new -h`}

      it {output.should match(/^Usage:/)}
      it {output.should match(/\s*kohana new PROJECT_NAME \[options\]/)}
      it {output.should match(/Options:/)}
      it {output.should match(/-p\s*\# Apache public directory/)}
      it {output.should match(/# Default: \/Application\/MAMP\/htdocs/)}
      it {output.should match(/-m\s*# Modules to load \(can pass more than one at the same time\)/)}
      it {output.should match(/# Available modules:/)}
      it {output.should match(/#\s*auth\s*=> Basic authentication/)}
      it {output.should match(/#\s*cache\s*=> Caching with multiple backends/)}
      it {output.should match(/#\s*codebench\s*=> Benchmarking tool/)}
      it {output.should match(/#\s*database\s*=> Database access/)}
      it {output.should match(/#\s*image\s*=> Image manipulation/)}
      it {output.should match(/#\s*minion\s*=> CLI Tasks/)}
      it {output.should match(/#\s*orm\s*=> Object Relationship Mapping/)}
      it {output.should match(/#\s*unittest\s*=> Unit testing/)}
      it {output.should match(/#\s*userguide\s*=> User guide and API documentation/)}
      it {output.should match(/-V\s*# Silent mode/)}
      it {output.should match(/# Default: false/)}
    end
  end
end
