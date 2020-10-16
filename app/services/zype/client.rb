# frozen_string_literal: true

module Zype
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

    def build_videos_data(videos)
      Zype::Data.new.build_videos_data(videos)
    end

    def build_video_data(video)
      Zype::Data.new.build_video_data(video)
    end

    def pagination(data)
      Zype::Pagination.new.paginate(data)
    end
	end
end