module ApplicationHelper

  def genderize_tag(model, tag)
    t(model.genderize(tag), model: t('activerecord.models.' + model.class.model_name.param_key + '.one')).downcase.capitalize
  end

  def genderize_title(model, tag)
    t(model.genderize(tag), model: t('activerecord.models.' + model.name.param_key + '.one'))
  end

  def link_to_add_fields(name, f, association)
    new_object = f.object.class.reflect_on_association(association).klass.new
    fields = f.fields_for(association, new_object, :child_index => "new_#{association}") do |builder|
      render(association.to_s.singularize + "_fields", :f => builder)
    end

    link_to_function(name, "add_fields(this, \"#{association}\", \"#{escape_javascript(fields)}\")")
  end

  def link_to_function(name, *args, &block)
     html_options = args.extract_options!.symbolize_keys

     function = block_given? ? update_page(&block) : args[0] || ''
     onclick = "#{"#{html_options[:onclick]}; " if html_options[:onclick]}#{function}; return false;"
     href = html_options[:href] || '#'

     content_tag(:a, name, html_options.merge(:href => href, :onclick => onclick, :class => 'btn btn-primary btn-xs', :style => " vertical-align:middle; horizontal-align:center;"))
  end

  def genderize_full_tag(model, full_tag)
    t(model.genderize(full_tag))
  end

  def flash_message
    messages = ""
    [:notice, :info, :warning, :error].each {|type|
      if flash[type]
        messages += "<p class=\"#{type}\">#{flash[type]}</p>"
      end
    }

    messages
  end

  require 'open-uri'

  def internet_connection?
    begin
      true if open("http://www.google.com/")
    rescue
      false
    end
  end

end
