class ErrorsController < ApplicationController
  def not_found
    @title = t('error_pages.not_found.title')
    @body = t('error_pages.not_found.body')
    @breadcrumbs = Hash[I18n.t('helpers.error') => '']

    render 'error', status: :not_found
  end

  def internal_server_error
    @title = t('error_pages.internal_server_error.title')
    @body = t('error_pages.internal_server_error.body')
    @breadcrumbs = Hash[I18n.t('helpers.error') => '']

    render 'error', status: :internal_server_error
  end
end
