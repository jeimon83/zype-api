# frozen_string_literal: true

module Zype
  class Oauth
    #include ActiveRecord::Integration

    def initialize
      @access_token = fetch_token
    end

    def fetch_token
      Rails.cache.fetch("zype_access_token", expires_in: 1.hour) { fetch_new_token }
    end

    private

    def fetch_new_token
      request = Typhoeus::Request.new(
        login_url,
        method: :post,
        params: oauth_params
      )

      response = request.run
      JSON.parse(response.response_body.to_s)['access_token']
    end

    def login_url
      "#{Rails.configuration.zype_login_url}/oauth/token"
    end

    def oauth_params
      {
        client_id:     Rails.configuration.zype_api_client_id,
        client_secret: Rails.configuration.zype_api_client_secret,
        username:      Rails.configuration.zype_username,
        password:      Rails.configuration.zype_password,
        grant_type:    Rails.configuration.zype_password
      }
    end
  end
end