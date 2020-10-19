# frozen_string_literal: true

# Module Zype
module Zype
  # Class Client
  class Client
    def fetch_and_save_videos
      Zype::Videos.new.fetch_and_save_videos
    end

    def validate_entitlement(id, access_token)
      Zype::Consumer.new.validate_entitlement(id, access_token)
    end

    def authenticate(login)
      Zype::Oauth.new(login).fetch_token
    end
  end
end
