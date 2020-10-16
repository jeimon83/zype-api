module Zype
  class Data
    def build_videos_data(videos)
      video_data = []
      videos.map do |video|
        video_width = video.dig('thumbnails', 0, 'width')
        next if video_width < 426

        video_data << {
          id: video['_id'],
          title: video['title'],
          subscription: video['subscription_required'],
          image: video.dig('thumbnails', 0, 'url'),
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
      "https://player.zype.com/embed/#{id}.js?autoplay=true&app_key=#{app_key}"
    end

    def app_key
      Rails.configuration.zype_app_key
    end
  end
end
