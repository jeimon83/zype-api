require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module ZypeChallenge
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0
    config.time_zone = "America/Argentina/Buenos_Aires"

    # Config vars
    config.zype_base_url      = ENV['ZYPE_BASE_URL']
    config.zype_app_key       = ENV['ZYPE_APP_KEY']
    config.zype_client_id     = ENV['ZYPE_CLIENT_ID']
    config.zype_client_secret = ENV['ZYPE_CLIENT_SECRET']
    config.zype_login_url     = ENV['ZYPE_LOGIN_URL']
  end
end
