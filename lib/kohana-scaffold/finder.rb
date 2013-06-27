module KohanaScaffold
  module Finder
    extend self

    COMMANDS = {
      "new"   => KohanaScaffold::Runner::New,
      "help"  => KohanaScaffold::Runner::Help
    }

    def localize_command(args)
      begin
        action = args.shift
        runner = runner_for(action)
        runner.run(args)
      rescue Thor::RequiredArgumentMissingError
        runner.help
      end
    end

    def runner_for(action)
      COMMANDS.fetch(action, KohanaScaffold::Runner::Help)
    end
  end
end
