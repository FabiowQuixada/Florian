class EmailConfigurationController < ApplicationController

  before_filter :authenticate_user!

  def edit
     @email_config = EmailConfiguration.find 1

     @breadcrumbs = Hash[Email.new.model_name.human(:count => 2) => send('emails_path'), t('helpers.action.email.config') => ""]
  end

  def update
    @email_config = EmailConfiguration.find params[:id]

    @message = genderize_tag @email_config, 'updated'

    if @email_config.update configuration_params
      redirect_to emails_path, notice: @message
    else
      render 'edit'
    end
  end

  private

    def configuration_params
      params.require(:email_configuration).permit(:signature, :test_recipient, :bcc)
    end
end
