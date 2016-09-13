class ActionView::Helpers::FormBuilder
  alias orig_label label

  # add a 'required' CSS class to the field label if the field is required
  def label(attr_name, content_or_options = nil, options = nil, &block)
    options, content = define_content_or_options content_or_options
    options = add_required_class options, attr_name
    orig_label(attr_name, content, options || {}, &block)
  end

  private

  def add_required_class(options, attr_name)
    if required? attr_name
      if options.class != Hash
        options = { class: 'required' }
      else
        options[:class] = ((options[:class] || '') + ' required').split(' ').uniq.join(' ')
      end
    end

    options
  end

  def define_content_or_options(content_or_options)
    if content_or_options && content_or_options.class == Hash
      options = content_or_options
    else
      content = content_or_options
    end

    [options, content]
  end

  def required?(attr_name)
    object.class.respond_to?(:validators_on) &&
      object.class.validators_on(attr_name).map(&:class).include?(ActiveRecord::Validations::PresenceValidator)
  end
end
