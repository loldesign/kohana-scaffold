module KohanaScaffold
  module Finder
    extend self

    COMMANDS = {
      "new"       => KohanaScaffold::AppGenerator,
      "scaffold"  => KohanaScaffold::ScaffoldGenerator,
      "help"      => KohanaScaffold::Help
    }

    def localize_command(args)
      action = args.shift
      runner_for(action).start(args)
    end

    def runner_for(action)
      COMMANDS.fetch(action, KohanaScaffold::Help)
    end
  end
end
