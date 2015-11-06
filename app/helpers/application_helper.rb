module ApplicationHelper
  
  def genderize_tag(model, tag)
    t(model.genderize(tag), model: t('activerecord.models.' + model.class.name.downcase + '.one')).downcase.capitalize
  end
  
  def genderize_title(model, tag)
    t(model.genderize(tag), model: t('activerecord.models.' + model.class.name.downcase + '.one'))
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
