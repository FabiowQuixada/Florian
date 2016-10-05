require 'rails_helper'

describe ApplicationController do
  controller do
    def index
      raise ApplicationController::AccessDenied
    end
  end

  let(:no_internet_exc) { SocketError.new 'getaddrinfo: Name or service not known' }
  let(:smtp_exc) { Net::SMTPFatalError.new '553-5.1.2 etc' }
  let(:florian_exc) { FlorianException.new 'Some exception' }
  let(:common_exception) { StandardError.new }

  it { expect(controller.handle_exception(no_internet_exc)).to eq I18n.t('exception.no_internet_connection') }
  it { expect(controller.handle_exception(smtp_exc)).to eq I18n.t('exception.invalid_recipient') }
  it { expect(controller.handle_exception(florian_exc)).to eq florian_exc.message }
  it { expect(controller.handle_exception(common_exception, 'mensagem customizada')).to eq 'mensagem customizada' }
end
