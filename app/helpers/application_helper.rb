require './lib/modules/locale_helper'
require './lib/modules/button_helper'

module ApplicationHelper

  include LocaleHelper
  include ButtonHelper
  include ActionView::Helpers::TagHelper

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
    render 'others/menu_item', klass: klass, display_name: display_name
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

  def currency
    t('number.currency.format.unit') + ' '
  end


  private ############################################################################################

  def footer_env
    "(#{t('environments.' + Rails.env)})" if !current_user.nil? && current_user.admin?
  end

  def showcase_login_screen?
    Rails.env == 'showcase' && request.env['PATH_INFO'] == '/users/sign_in'
  end
end
