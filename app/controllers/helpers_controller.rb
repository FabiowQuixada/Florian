class HelpersController < ApplicationController

  def email_row
    render partial: 'shared/email_address', locals: { email_address: params[:email_address], index: params[:index], field_name: params[:field_name] }
  end
end
