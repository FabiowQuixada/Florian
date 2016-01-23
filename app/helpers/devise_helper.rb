module DeviseHelper
  def devise_error_messages!
    return "" if resource.errors.empty?

    messages = resource.errors.full_messages.map { |msg|  }.join
    sentence = I18n.t("errors.messages.not_saved",
                      :count => resource.errors.count,
                      :resource => resource.class.model_name.human.downcase)

    model = Object.new

    resource.errors.full_messages.each do |msg|
      model.errors.add(:base, msg)
    end

    render 'helpers/form_errors', :model => model
  end

  def devise_error_messages?
    resource.errors.empty? ? false : true
  end

end