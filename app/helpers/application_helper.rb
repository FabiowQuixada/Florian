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

  def menu(klass, display_name = nil)
    display_name ||= plural_of(klass)
    render partial: 'others/menu_item', locals: { klass: klass, display_name: display_name }
  end

  ## Buttons ###################################################

  def profile_btn
    link_to current_user.name, edit_user_registration_path
  end

  def logout_btn
    link_to t('helpers.action.logout'), destroy_user_session_path, method: :delete, style: 'margin-left: 5px;', class: 'btn btn-primary btn-xs'
  end

  def new_btn(model)
    path = send "new_#{model.class.to_s.underscore}_path", model
    link_to genderize_full_tag(model, 'helpers.action.new'), path, class: 'btn btn-primary'
  end

  def save_update_btn(_model, form)
    button_text = (@model.persisted? ? t('helpers.action.update') : t('helpers.action.save'))
    form.submit button_text, class: 'btn btn-primary save_btn'
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

  def form_back_btn
    content_tag :a, t('helpers.action.back'), id: 'form_back_btn', class: 'btn btn-primary back_btn'
  end

  def destroy_btn
    image_tag('destroy.png', title: t('helpers.action.destroy'), class: 'destroy_btn')
  end

  def admin_info_btn
    link_to image_tag('key.png', title: t('helpers.action.show_admin_private_data')), 'javascript:void(0)', class: 'admin_key_btn' if current_user.admin?
  end

  def author_email_btn
    link_to t('author'), 'javascript:void(0)', id: 'author_email_btn'
  end

  def sub_edit_btn(klass)
    image_tag 'edit.png', title: t('helpers.action.edit'), class: "edit_#{klass.to_s.underscore}_btn edit_btn"
  end

  def sub_destroy_btn(klass)
    link_to image_tag('delete.png', title: t('helpers.action.remove')), 'javascript:void(0)', class: "remove_#{klass.to_s.underscore}_btn remove_btn"
  end

  ## Images #########################################################################

  def trash_img(field_name)
    image_tag('delete.png', title: t('helpers.action.remove'), class: field_name + '_remove_recipient_btn remove_btn')
  end

  def activate_img(iterator)
    image_tag('deactivate.png', title: genderize_tag(iterator, 'is_inactive'), class: 'activate_btn status_btn')
  end

  def deactivate_img(iterator)
    image_tag('activate.png', title: genderize_tag(iterator, 'is_active'), class: 'deactivate_btn status_btn')
  end

  ## Other #######################################

  def app_footer
    t('app_title') + " #{Time.now.year} #{footer_env}"
  end

  def showcase_login_msg
    "display_hideless_warning('#{t('showcase.login_info', showcase_email: bold('visitante' + GUEST_USERS_NUMBERS.sample.to_s + '@florian.com'), showcase_password: bold(SHOWCASE_PASSWORD))}');".html_safe if showcase_login_screen?
  end

  def no_records_row(model, list, colspan = 20)
    style = list.any? ? 'display:none' : ''

    content_tag :tr, id: "no_#{model.class.name.pluralize.underscore}_row", style: style do
      content_tag(:td, genderize_tag(model, 'helpers.none_registered'), colspan: colspan)
    end
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

  def footer_env
    "(#{t('environments.' + Rails.env)})" if !current_user.nil? && current_user.admin?
  end

  def app_about_btn
    link_to image_tag('info.png', title: t('helpers.about.title')), 'javascript:void(0)', id: 'app_about_btn'
  end

  def showcase_login_screen?
    Rails.env == 'showcase' && request.env['PATH_INFO'] == '/users/sign_in'
  end
end
