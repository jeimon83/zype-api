# frozen_string_literal: true

# frozen_string_literal: true

# Module Zype
module Zype
  # Class Oauth
  class Oauth
    def initialize(login)
      @username     = login[:username]
      @password     = login[:password]
      @access_token = fetch_token
    end

    def fetch_token
      Rails.cache.fetch('access_token', expires_in: 1.hour) do
        response = Typhoeus.post(login_url, params: oauth_params)
        return false if response.code != 200

        JSON.parse(response.response_body.to_s)['access_token']
      end
    end

    private

    def login_url
      "#{Rails.configuration.zype_login_url}/oauth/token"
    end

    def oauth_params
      {
        client_id:     Rails.configuration.zype_client_id,
        client_secret: Rails.configuration.zype_client_secret,
        username:      @username,
        password:      @password,
        grant_type:    'password'
      }
    end
  end
end
