require './lib/modules/locale'

module ApplicationHelper

  include Locale
  include ActionView::Helpers::TagHelper

  def genderize_full_tag(model, full_tag)
    t(model.genderize(full_tag))
  end

  def model_full_path(model)
    url_for(action: 'index', controller: model.model_name.route_key, only_path: false, protocol: 'http')
  end

  def bold(name)
    content_tag(:span, name, class: 'thick')
  end

  def plural_of(klass)
    klass.new.model_name.human(count: 2)
  end

  def edit_btn(iterator)
    edit_path = send("edit_#{iterator.class.to_s.underscore}_path", iterator)
    link_to image_tag('edit.png', title: t('helpers.action.edit')), edit_path
  end

  def status_btn(iterator)
    if iterator.active
      deactivation_btn iterator
    else
      activation_btn iterator
    end
  end

  def destroy_btn
    image_tag('destroy.png', title: t('helpers.action.destroy'), class: 'clickable destroy_btn')
  end

  def activate_img(iterator)
    image_tag('deactivate.png', title: genderize_tag(iterator, 'is_inactive'), class: 'activate_btn status_btn')
  end

  def deactivate_img(iterator)
    image_tag('activate.png', title: genderize_tag(iterator, 'is_active'), class: 'deactivate_btn status_btn')
  end

  private ############################################################################################

  def deactivation_btn(iterator)
    path = send("deactivate_#{iterator.class.to_s.underscore}_path", iterator)
    link_to deactivate_img(iterator), path, method: :post, remote: true, id: "change_status_#{iterator.id}", 'data-type' => :json, class: 'deactivate_btn'
  end

  def activation_btn(iterator)
    path = send("activate_#{iterator.class.to_s.underscore}_path", iterator)
    link_to activate_img(iterator), path, method: :post, remote: true, id: "change_status_#{iterator.id}", 'data-type' => :json, class: 'activate_btn'
  end
end
