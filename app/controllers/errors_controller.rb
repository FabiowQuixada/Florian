class ErrorsController < ApplicationController
  def not_found
    @title = t('error_pages.not_found.title')
    @body = t('error_pages.not_found.body')
    render 'error', :status => 404
  end

  def internal_server_error
    @title = t('error_pages.internal_server_error.title')
    @body = t('error_pages.internal_server_error.body')

    render 'error', :status => 500
  end
end
