# frozen_string_literal: true

module Zype
  class Videos < Oauth
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

    def api_app_key
      Rails.configuration.zype_api_app_key
    end

    def search_video_params(page)
      {
        page: page,
        per_page: 10,
        api_key: api_app_key,
        access_token: @access_token
      }
    end

    def fetch_video_params
      { 
        api_key: api_app_key, 
        access_token: @access_token
      }
    end
  end
end
