module ControllerHelper
  def model_class_name
    controller_name = nil
    self.class.name.split('::').each { |i| controller_name = i if i.ends_with? 'Controller' }
    controller_name[0..-11].singularize
  end

  def model_class
    Object.const_get model_class_name
  end

  def model_index_path
    send "#{model_class.model_name.route_key}_path"
  end

  def klass
    model_class_name.underscore
  end
end

RSpec.configure do |config|
  config.include ControllerHelper, type: :controller
end
