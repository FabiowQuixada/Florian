class EmailConfigurationController < ApplicationController

  before_filter :authenticate_user!
  before_action :before_edit, only: [:edit, :update]

  def edit
  end

  def update
    if @email_config.update configuration_params
      redirect_to emails_path, notice: genderize_tag(@email_config, 'updated')
    else
      render 'edit'
    end
  end

  private

    def configuration_params
      params.require(:email_configuration).permit(:signature, :test_recipient, :bcc)
    end

  def before_edit
    @email_config = EmailConfiguration.first

    @breadcrumbs = Hash[Email.new.model_name.human(:count => 2) => send('emails_path'), t('helpers.action.email.config') => ""]
  end

end
