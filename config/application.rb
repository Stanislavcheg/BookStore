require_relative 'boot'

require 'rails/all'

Bundler.require(*Rails.groups)

module BookStore
  class Application < Rails::Application
    config.load_defaults 5.1
    config.autoload_paths << "#{Rails.root}/app/form_objects/checkout/forms"
    config.autoload_paths << "#{Rails.root}/app/form_objects/checkout/form_builders"
  end
end
