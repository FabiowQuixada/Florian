require './lib/modules/locale'

class ApplicationController < ActionController::Base

  include Locale

  # 'info' is closeable, while 'waiting_msg' is not
  add_flash_types :info, :waiting_msg

  before_filter :configure_permitted_parameters, if: :devise_controller?

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :set_locale

  def set_locale

    # if I18n.locale == :'pt-BR'
      # I18n.locale = 'en'
    # else
      I18n.locale = 'pt-BR'
    # end
  end

  rescue_from CanCan::AccessDenied do |exc|
    logger.error("Exception catch [" + DateTime.now.strftime("%d/%m/%Y :: %H:%M:%S") + "] ==> " + exc.message + '\n' + exc.backtrace.join("\n"))
    redirect_to root_url, :alert => t('alert.access_denied')
  end

  def handle_exception(exc, default_message = nil)

    logger.error("Exception catch [" + DateTime.now.strftime("%d/%m/%Y :: %H:%M:%S") + "] ==> " + exc.message + '\n' + exc.backtrace.join("\n"))

    if exc.message. == 'getaddrinfo: Name or service not known'
      return I18n.t('exception.no_internet_connection')
    elsif exc.instance_of? Net::SMTPFatalError
      if(exc.message.starts_with? '553-5.1.2')
         return I18n.t('exception.invalid_recipient')
      end
    elsif exc.instance_of? FlorianException
      return exc.message
    end

    return default_message
  end


  protected ######################################################################################

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :name
    devise_parameter_sanitizer.for(:account_update) << :name
  end

  private ######################################################################################

  def after_sign_out_path_for(resource_or_scope)
    new_user_session_path
  end
end
