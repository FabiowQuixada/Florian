include LanguagesHelper

class WelcomeController < ApplicationController

  def index

    unless user_signed_in?
      redirect_to controller: 'devise/sessions', action: 'new'
    end

    # LanguagesHelper.build_void_languagemain
    @breadcrumbs = Hash[t('main_page') => '']
  end

end
