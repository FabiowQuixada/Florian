class IaqGenGenerator < Rails::Generators::NamedBase
  source_root File.expand_path('../templates', __FILE__)
  argument :name, type: :string
  class_option :singular
  class_option :plural

  def create_model

    copy_file "model.rb", "app/models/#{file_name}.rb"

    text = File.read("app/models/#{file_name}.rb")
    new_contents = text.gsub("ModelName", "#{file_name}".capitalize)

    if any_mandatory? args

      args2 = split args

      validation_line = "# Validations\n  validates "
      args2.each do |arg|
        if mandatory? arg
          validation_line += ":" + arg[0] + ", "
        end
      end

      validation_line += " :presence => true"

      extra_conf = ""
      args2.each do |arg|
        if arg[1] == 'money'
          extra_conf += "usar_como_dinheiro :" + arg[0] + "\n\t"
        end
      end


      new_contents = new_contents.gsub("#extra_conf", extra_conf)
      new_contents = new_contents.gsub("# Validations", validation_line)

    end

    File.open("app/models/#{file_name}.rb", "w") {|file| file.puts new_contents }
  end

  def generate_migration

    create_file "db/migrate/" + DateTime.now.strftime("%Y%m%d%H%M%S").to_s + "_create_" + "#{file_name}".pluralize + ".rb"

    args2 = split args

    temp = "class Create" + "#{file_name}".capitalize.pluralize + " < ActiveRecord::Migration
  def change
    create_table :" + "#{file_name}".pluralize + " do |t|\n"

      args2.each do |arg|
        temp += "\tt." + arg_db_type(arg) + " :" + arg.first


         if arg[1] == 'money'
           temp += ", :precision => 8, :scale => 2"
         elsif arg[1] == ''
         end

         if mandatory? arg
          temp += ", null: false"
        end

        temp += "\n"

      end

  temp += "\tt.timestamps null: false
    end
  end
end"

  File.open("db/migrate/" + DateTime.now.strftime("%Y%m%d%H%M%S").to_s + "_create_" + "#{file_name}".pluralize + ".rb", "w") {|file| file.puts temp }


  end

  def create_controller
      copy_file "controller.rb", "app/controllers/" + "#{file_name}".pluralize + "_controller.rb"

      text = File.read("app/controllers/" + "#{file_name}".pluralize + "_controller.rb")
      new_contents = text.gsub("ControllerName", "#{file_name}".capitalize.pluralize).gsub("ModelName", "#{file_name}".capitalize).gsub("model_name", "#{file_name}")

      temp = ":id"

      args2 = split args

      args2.each do |arg|
        temp += ", :" + arg.first
      end

      new_contents = new_contents.gsub("<< attributes >>", temp)

      File.open("app/controllers/" + "#{file_name}".pluralize + "_controller.rb", "w") {|file| file.puts new_contents }
    end

    def create_index
      copy_file "index.html.erb", "app/views/" + "#{file_name}".pluralize + "/index.html.erb"

      text = File.read("app/views/" + "#{file_name}".pluralize + "/index.html.erb")

      temp = ""
      args2 = split args
      args2.each_with_index do |arg, index|
        temp += "\tHash[:header => '" + arg.first + "', :model_attr => '" + arg.first + (arg[1] == 'money'? "', :type => 'money" : "") + "']"

        if index != (args.size - 1)
          temp += ',' + "\n"
        end
      end

      text = text.gsub(" << attributes >>", temp)

      File.open("app/views/" + "#{file_name}".pluralize + "/index.html.erb", "w") {|file| file.puts text }
    end

    def create_form
      copy_file "_form.html.erb", "app/views/" + "#{file_name}".pluralize + "/_form.html.erb"

      text = File.read("app/views/" + "#{file_name}".pluralize + "/_form.html.erb")

      temp = ""

      args2 = split args

      args2.each do |arg|

        if arg[1] == 'money'
          temp += "
\t\t<div class='row'>
\t\t\t<div class='form-group col-md-12'>
\t\t\t\t<%= f.label :" + arg.first + " %>
\t\t\t\t<div class=\"input-group\">
\t\t\t\t\t<span class=\"input-group-addon\">R$</span>
\t\t\t\t\t<%= f.text_field :" + arg.first + ", :class => 'form-control money' %>
\t\t\t\t</div>
\t\t\t</div>
\t\t</div>\n"
        elsif  arg[1] == 'date'
          temp += "
\t\t<div class='row'>
\t\t\t<div class='form-group col-md-12'>
\t\t\t\t<%= f.label :" + arg.first + " %>
\t\t\t\t<div class=\"input-group date\" data-behaviour='datepicker' >
\t\t\t\t\t<%= f.text_field :" + arg.first + ", {:class => 'form-control'} %><span class=\"input-group-addon\"><i class=\"glyphicon glyphicon-th\"></i></span>
\t\t\t\t</div>
\t\t\t</div>
\t\t</div>\n"
        elsif  arg[1] == 'text'
          temp += "
\t\t<div class='row'>
\t\t\t<div class='form-group col-md-12'>
\t\t\t\t<%= f.label :" + arg.first + " %>
\t\t\t\t<%= f.text_area :" + arg.first + ", size: '24x6', :class => 'form-control' %>
\t\t\t</div>
\t\t</div>\n"


        else

          temp += "
\t\t<div class='row'>
\t\t\t<div class='form-group col-md-12'>
\t\t\t\t<%= f.label :" + arg.first + " %>
\t\t\t\t<%= f.text_field :" + arg.first + ", :class => 'form-control' %>
\t\t\t</div>
\t\t</div>\n"
        end

      end

      text = text.gsub("<< fields >>", temp)

      File.open("app/views/" + "#{file_name}".pluralize + "/_form.html.erb", "w") {|file| file.puts text }
    end

    def update_locale_file

      text = File.read("config/locales/pt-BR.yml")

      temp = "    attributes:\n      #{file_name}:\n"
      args2 = split args
      args2.each_with_index do |arg, index|
        temp += "        " + arg.first + ": " + arg.first

        if index != (args.size - 1)
          temp += "\n"
        end
      end

      text = text.gsub("    attributes:", temp)

    singular = plural = "#{file_name}"
    singular = options[:singular].capitalize unless options[:singular].nil?
    plural = options[:plural].capitalize unless options[:plural].nil?

      temp ="    models:\n      #{file_name}:\n        one: " + singular + "\n        other: " + plural
      text = text.gsub("    models:", temp)

      File.open("config/locales/pt-BR.yml", "w") {|file| file.puts text }
    end

     def update_menu
       text = File.read("app/views/others/_menu.html.erb")

       temp = "<li>
                <a href='/" + "#{file_name}".pluralize + "'><%= " + "#{file_name}".capitalize + ".new.model_name.human(:count => 2) %></a>
            </li>
            <!-- new_menus_here -->"

       text = text.gsub("<!-- new_menus_here -->", temp)

       File.open("app/views/others/_menu.html.erb", "w") {|file| file.puts text }
     end

    def update_routes
      text = File.read("config/routes.rb")

      new_routes = "# Automatic resources\n  resources :" + "#{file_name}".pluralize

      text = text.gsub("# Automatic resources", new_routes)

      File.open("config/routes.rb", "w") {|file| file.puts text }
    end

    private

      def arg_db_type(arg)
        if arg[1] == 'money'
         return 'decimal'
       end

       arg[1]
      end

      def mandatory?(arg)
        !arg[2].nil?
      end

      def split(args)
        args2 = []

        args.each do |arg|
          args2 << arg.split(':')
        end

        args2

      end

      def any_mandatory?(args)
        args2 = split args

        args2.each do |arg|
          if mandatory? arg
            return true
          end
        end

        return false
      end
end
