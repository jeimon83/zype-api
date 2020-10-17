# frozen_string_literal: true

# Module Zype
module Zype
  # Class Videos
  class Videos
    def search_videos(page)
      response = Typhoeus.get(video_url, params: search_video_params(page))
      videos_search_result = JSON.parse(response.response_body.to_s)
      final_videos_data = []
      final_videos_data << build_videos_data(videos_search_result['response'])
      final_videos_data << build_paginate_data(videos_search_result['pagination'])      
      final_videos_data
    end

    def fetch_video(id)
      response = Typhoeus.get(video_url + "/#{id}", params: { app_key: app_key })
      video = JSON.parse(response.response_body.to_s)
      video_attributes(video['response'])
    end

    private

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

    def build_videos_data(videos)
      videos_data = []
      videos.map do |video|
        video_width = video.dig('thumbnails', 0, 'width')
        next if video_width < 426

        videos_data << {
          id: video['_id'],
          title: video['title'],
          subscription: video['subscription_required'],
          image: video.dig('thumbnails', 0, 'url')
        }
      end
      videos_data
    end

    def video_attributes(video)
      {
        id: video['_id'],
        subscription: video['subscription_required'],
        embeded_player: embeded_player(video['_id'])
      }
    end

    def build_paginate_data(pages)
      {
        current_page: pages['current'],
        next_page: pages['next'],
        previous_page: pages['previous'],
        total_pages: pages['pages']
      }
    end

    def embeded_player(id)
      "https://player.zype.com/embed/#{id}.js?autoplay=true&app_key=#{app_key}"
    end
  end
end
