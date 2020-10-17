# frozen_string_literal: true

# Module Zype
module Zype
  # Class Client
  class Client
    def search_videos(page)
      Zype::Videos.new.search_videos(page)
    end

    def fetch_video(id)
      Zype::Videos.new.fetch_video(id)
    end

    def validate_consumer(video_id)
      Zype::Consumer.new.validate_consumer(video_id)
    end

    def authenticate(login)
      Zype::Oauth.new(login).fetch_token
    end
  end
end
