# frozen_string_literal: true

# Module Zype
module Zype
  # Class Videos
  class Videos
    def search_videos(page)
      response = Typhoeus.get(video_url, params: search_video_params(page))
      JSON.parse(response.response_body.to_s)
    end

    def fetch_video(id)
      response = Typhoeus.get(video_url + "/#{id}", params: { app_key: app_key })
      video = JSON.parse(response.response_body.to_s)
      video_attributes(video['response'])
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

    def video_attributes(video)
      {
        id: video['_id'],
        subscription: video['subscription_required'],
        embeded_player: embeded_player(video['_id'])
      }
    end

    def embeded_player(id)
      "https://player.zype.com/embed/#{id}.js?autoplay=true&app_key=#{app_key}"
    end
  end
end
