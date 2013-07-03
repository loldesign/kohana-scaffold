module KohanaScaffold
  class ScaffoldGenerator < Thor::Group
    include Thor::Actions

    argument :name
    argument :fields, type: :array, default: []

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
      controller_template = configured_database? ? "controller_database.erb" : "controller.erb"
      template(controller_template, controller_file)
    end

    def create_view
      index_template = configured_database? ? "index_database.erb" : "index.erb"
      template(index_template, index_file)

      show_template = configured_database? ? "show_database.erb" : "show.erb"
      template(show_template, show_file)
    end

    def create_model
      if configured_database?
        template("model.erb", "application/classes/Model/#{name.capitalize}.php")
      end
    end

    def add_link_to_menu
      resource_link = "\t<li><?= html::anchor('#{name.downcase.pluralize}', '#{name.capitalize.pluralize}') ?></li>\n"
      inject_into_file('application/views/layout/application.php', resource_link, before: "</ul>")
    end

    private

    def configured_database?
      File.exist?("application/config/database.php")
    end

    def controller_file
      "application/classes/Controller/#{name.capitalize.pluralize}.php"
    end

    def index_file
      "application/views/#{name}/index.php"
    end

    def show_file
      "application/views/#{name}/show.php"
    end
  end
end
