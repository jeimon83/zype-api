# frozen_string_literal: true

module Zype
  class Oauth
    def initialize(params)
      @email = params[:username]
      @password = params[:password]
      @access_token = fetch_token
    end

    def fetch_token
      Rails.cache.fetch("zype_access_token", expires_in: 1.hour) { fetch_new_token }
    end

    private

    attr_reader :username, :password

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
        client_id:     Rails.configuration.zype_client_id,
        client_secret: Rails.configuration.zype_client_secret,
        username:      username,
        password:      password,
        grant_type:    password
      }
    end
  end
end