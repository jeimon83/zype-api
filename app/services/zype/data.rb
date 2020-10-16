module Zype
  class Data
    def build_videos_data(videos)
      video_data = []
      videos.map do |video|
        video_data << {
          id: video['_id'],
          subscription: video['subscription_required'],
          image: video['thumbnails'].first['url']
        }
      end
      video_data
    end

    def build_video_data(video)
      {
        id: video['_id'],
        title: video['title'],
        subscription: video['subscription_required'],
        embeded_player: embeded_player(video['_id'])
      }
    end

    def embeded_player(id)
      "https://player.zype.com/embed/#{id}.js?autoplay=true&app_key=#{api_app_key}"
    end

    def api_app_key
      Rails.configuration.zype_api_app_key
    end
  end
end
