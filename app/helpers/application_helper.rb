require './lib/modules/locale_helper'
require './lib/modules/button_helper'

module ApplicationHelper

  include LocaleHelper
  include ButtonHelper
  include ActionView::Helpers::TagHelper

  def breadcrumbs
    @breadcrumbs.collect do |bc|
      content_tag :li,
                  bc[1] == '' ? bc.first : link_to(bc[0], bc[1]),
                  class: ('active thick' if bc == @breadcrumbs.to_a.last)
    end.join.html_safe
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
    render 'others/menu_item', klass: klass, display_name: display_name
  end

  def filter_date_field(f, att)
    f.search_field att, value: params[:q] && params[:q][att] ? I18n.l(params[:q][att].to_date) : '', class: 'form-control date mb-0'
  end

  def filter_competence_field(f, att)
    f.search_field att, value: params[:q] && params[:q][att] ? I18n.l(params[:q][att].to_date, format: I18n.t('date.formats.competence_i')) : '', class: 'form-control date mb-0 hidden'
  end

  def filter_aux_competence_field(f, att)
    f.text_field att, value: params[:q] && params[:q][att] ? I18n.l(params[:q][att].to_date, format: I18n.t('date.formats.competence_i')) : '', id: "aux_#{att}", class: 'form-control date mb-0'
  end

  def date_field(f, att)
    f.text_field att, value: (@model.send(att).nil? ? '' : I18n.l(@model.send(att))), class: 'form-control date'
  end

  def money_field(f, att)
    f.text_field att, value: number_to_currency(@model.send(att).to_f, unit: ''), class: 'form-control money'
  end

  def audit_user(audit, index)
    if index == 0
      t 'audit.auto_creation_user'
    else
      audit.user.name unless audit.user.nil?
    end
  end

  def audit_ip(audit, index)
    if index == 0
      t 'audit.auto_creation_ip'
    else
      audit.remote_address
    end
  end

  ## Images #########################################################################

  def trash_img(field_name)
    image_tag('delete.png', title: t('helpers.action.remove'), class: "#{field_name}_remove_recipient_btn remove_btn")
  end

  def activate_img(iterator)
    image_tag('deactivate.png', title: genderize_tag(iterator, 'model_phrases.status.is_inactive'), class: 'activate_btn status_btn')
  end

  def deactivate_img(iterator)
    image_tag('activate.png', title: genderize_tag(iterator, 'model_phrases.status.is_active'), class: 'deactivate_btn status_btn')
  end

  def arrow_down
    image_tag('arrow_down.png', class: 'arrow-down')
  end

  ## Other #######################################

  def app_footer
    t('app_data.app_title') + " #{Time.now.year} #{footer_env}"
  end

  def showcase_login_msg
    "display_hideless_warning('#{t('showcase.login_info', showcase_email: bold(SHOWCASE_USER.underscore + '_' + GUEST_USERS_NUMBERS.sample.to_s + '@florian.com'), showcase_password: bold(SHOWCASE_PASSWORD))}');".html_safe if showcase_login_screen?
  end

  def no_records_row(model, list, colspan = 20)
    style = list.any? ? 'display:none' : ''

    content_tag :tr, id: "no_#{model.class.name.pluralize.underscore}_row", style: style do
      content_tag(:td, genderize_tag(model, 'model_phrases.none_registered'), colspan: colspan)
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
    Rails.env.showcase? && request.env['PATH_INFO'] == '/users/sign_in'
  end
end
