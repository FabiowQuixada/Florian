require './lib/modules/locale_helper'

class ApplicationController < ActionController::Base

  include LocaleHelper

  # 'info' is closeable, while 'waiting_msg' is not
  add_flash_types :info, :waiting_msg

  before_filter :configure_permitted_parameters, if: :devise_controller?
  before_filter :set_locale

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  rescue_from CanCan::AccessDenied do |exc|
    logger.error "Exception catch [#{DateTime.now.strftime('%d/%m/%Y :: %H:%M:%S')}] ==> #{exc.message}\n" + exc.backtrace.join("\n")
    redirect_to root_url, alert: t('alert.access_denied')
  end

  def handle_exception(exc, default_message = nil)
    log_error exc
    return I18n.t('exception.no_internet_connection') if exc.message == 'getaddrinfo: Name or service not known'
    return I18n.t('exception.invalid_recipient') if exc.instance_of?(Net::SMTPFatalError) && exc.message.starts_with?('553-5.1.2')
    return exc.message if exc.instance_of? FlorianException
    default_message
  end

  protected ######################################################################################

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :name
    devise_parameter_sanitizer.for(:account_update) << :name
  end

  def formatted_date(date_param)
    return nil if date_param.nil? || date_param == ''
    return Date.strptime(date_param, '%m/%d/%Y').strftime('%F') unless date_param =~ /\d\d\d\d-\d\d-\d\d/
    date_param
  end

  def format_filter_date(param)
    params[:q][param] = formatted_date params[:q][param] if params[:q]
  end

  def index_path
    url_for(action: 'index', controller: model_class.model_name.route_key, only_path: false, protocol: 'http')
  end

  def breadcrumbs
    if params[:action] == 'index'
      Hash[plural_of(model_class) => '']
    else
      Hash[plural_of(model_class) => index_path]
    end
  end

  private ######################################################################################

  def model_class_name
    controller_name = nil
    self.class.name.split('::').each { |i| controller_name = i if i.ends_with? 'Controller' }
    controller_name[0..-11].singularize
  end

  def model_class
    Object.const_get model_class_name
  end

  def plural_of(klass)
    klass.new.model_name.human count: 2
  end

  def after_sign_out_path_for(_resource_or_scope)
    new_user_session_path
  end

  def log_error(exc)
    backtrace = ''
    backtrace = exc.backtrace.each { |line| logger.error line } unless exc.backtrace.nil?
    logger.error "Exception catch [#{DateTime.now.strftime('%d/%m/%Y :: %H:%M:%S')}] ==> #{exc.message}\n #{backtrace}"
  end

  def set_locale
    locale = :en
    locale = current_user.locale if current_user
    I18n.locale = locale
  end
end
