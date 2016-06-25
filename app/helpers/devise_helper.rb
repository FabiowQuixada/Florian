module DeviseHelper
  def devise_error_messages!
    return '' if resource.errors.empty?

    model = ReceiptEmail.new

    resource.errors.full_messages.each do |msg|
      model.errors.add(:base, msg)
    end

    render 'shared/form_errors', model: model
  end

  def devise_error_messages?
    !resource.errors.empty?
  end

end
