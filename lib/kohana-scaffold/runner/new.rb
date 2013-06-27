module KohanaScaffold
  module Runner
    module New
      extend self

      def run(args)
        return help if args.include?("-h")

        project_name = args.shift
        KohanaScaffold::AppGenerator.new([project_name], args).invoke_all
      end

      def help
        Kernel.puts "Usage: "+
                "\n  kohana new PROJECT_NAME [options]\n"+
                "\nOptions:"+
                "\n  -p    # Apache public directory"+
                "\n        # Default: /Application/MAMP/htdocs"+
                "\n  -m    # Modules to load (can pass more than one at the same time)"+
                "\n        # Available modules:"+
                "\n        #     auth        => Basic authentication"+
                "\n        #     cache       => Caching with multiple backends"+
                "\n        #     codebench   => Benchmarking tool"+
                "\n        #     database    => Database access"+
                "\n        #     image       => Image manipulation"+
                "\n        #     minion      => CLI Tasks"+
                "\n        #     orm         => Object Relationship Mapping"+
                "\n        #     unittest    => Unit testing"+
                "\n        #     userguide   => User guide and API documentation"+
                "\n  -V    # Silent mode"+
                "\n        # Default: false"
      end
    end
  end
end
