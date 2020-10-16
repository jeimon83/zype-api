# frozen_string_literal: true

module Zype
  class Videos
    def search_videos(page)
      response = Typhoeus.get(video_url, params: search_video_params(page))
      JSON.parse(response.response_body.to_s)
    end

    def fetch_video(id)
      response = Typhoeus.get(video_url + "/#{id}", params: fetch_video_params )
      JSON.parse(response.response_body.to_s)
    end

    private

    def video_url
      "#{Rails.configuration.zype_base_url}/videos"
    end

    def app_key
      Rails.configuration.zype_app_key
    end

    def search_video_params(page)
      {
        page: page || 1,
        per_page: 12,
        app_key: app_key
      }
    end

    def fetch_video_params
      { 
        app_key: app_key
      }
    end
  end
end
