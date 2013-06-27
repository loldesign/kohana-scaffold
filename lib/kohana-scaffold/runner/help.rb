module KohanaScaffold
  module Runner
    module Help
      extend self

      def run(args=[])
        Kernel.puts "Usage: kohana COMMAND [ARGS]\n"+
        "\nList of commands:"+
        "\n new     Create a new Kohana application. Ex.: \"kohana new sample\" creates a new application on MAMP folder (by default)"+
        "\n help    Show this message\n"+
        "\nAll commands can be run with -h for more information."
      end
    end
  end
end
