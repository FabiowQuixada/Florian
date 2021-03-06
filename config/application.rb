require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module FlorianProject
  class Application < Rails::Application

    config.action_view.embed_authenticity_token_in_remote_forms = true

    Prawn::Font::AFM.hide_m17n_warning = true

    config.exceptions_app = routes
    config.autoload_paths += %W(#{config.root}/lib/modules)

    # Avoids insertion of a error message div in the forms, which would break the layout
    config.action_view.field_error_proc = proc { |html_tag, _instance|
      html_tag
    }

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    config.time_zone = 'Brasilia'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    config.i18n.available_locales = [:en, :"pt-BR"]
    config.i18n.default_locale = :en

    # Do not swallow errors in after_commit/after_rollback callbacks.
    config.active_record.raise_in_transactional_callbacks = true

    # Javascript internationalitaion
    config.middleware.use I18n::JS::Middleware
  end
end
