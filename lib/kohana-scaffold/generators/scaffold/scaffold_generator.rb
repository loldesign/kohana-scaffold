module KohanaScaffold
  class ScaffoldGenerator < Thor::Group
    include Thor::Actions

    argument :name

    def self.source_root
      File.join(File.dirname(__FILE__), 'templates')
    end

    def validate
      unless File.exist?("application/bootstrap.php")
        Kernel.puts "To run kohana scaffold please go to the project root folder."
        Kernel::exit
      end
    end

    def create_controller
      template("controller.erb", "application/classes/Controller/#{name.capitalize.pluralize}.php")
    end

    def create_view
      template("index.erb", "application/views/#{name}/index.php")
      template("show.erb", "application/views/#{name}/show.php")
    end

    def add_link_to_menu
      resource_link = "\t<li><?= html::anchor('#{name.downcase.pluralize}', '#{name.capitalize.pluralize}') ?></li>\n"
      inject_into_file('application/views/layout/application.php', resource_link, before: "</ul>")
    end
  end
end
