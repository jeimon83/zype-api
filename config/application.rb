require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module ZypeChallenge
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

    config.zype_base_url          = ENV['ZYPE_BASE_URL']
    config.zype_api_app_key       = ENV['ZYPE_API_APP_KEY']
    config.zype_api_client_id     = ENV['ZYPE_API_CLIENT_ID']
    config.zype_api_clien_secret  = ENV['ZYPE_API_CLIENT_SECRET']
    config.zype_login_url         = ENV['ZYPE_LOGIN_URL']
  end
end
