include LanguagesHelper

class WelcomeController < ApplicationController

  before_filter :authenticate_user!

  def index
    #LanguagesHelper.build_void_languagemain
    @breadcrumbs = Hash["Página Principal" => ""]
  end

end
