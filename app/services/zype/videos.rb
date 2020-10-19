# frozen_string_literal: true

# Module Zype
module Zype
  # Class Videos
  class Videos
    def fetch_and_save_videos
      page = 1
      total_pages = retrieve_total_pages(page)
      begin 
        response = retrieve_videos_by_page(page)
        videos_search_result = JSON.parse(response.response_body.to_s)
        Video.save_external_data(videos_search_result['response'])
        page += 1
      end while page <= total_pages
    end

    private

    def retrieve_total_pages(page)
      response = retrieve_videos_by_page(page)
      JSON.parse(response.response_body.to_s)['pagination']['pages']
    end

    def retrieve_videos_by_page(page)
      Typhoeus.get(video_url, params: search_video_params(page))
    end

    def video_url
      "#{Rails.configuration.zype_base_url}/videos"
    end

    def search_video_params(page)
      {
        page: page || 1,
        per_page: 25,
        app_key: app_key
      }
    end

    def app_key
      Rails.configuration.zype_app_key
    end
  end
end
