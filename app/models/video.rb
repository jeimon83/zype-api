# frozen_string_literal: true

class Video < ApplicationRecord
  include ApplicationHelper
  
  self.per_page = 50

  def self.save_external_data(external_videos)
    external_videos.each do |external_video|
      external_video_width = external_video.dig('thumbnails', 0, 'width')
      next if external_video_width < 426

      video = Video.find_or_initialize_by(external_reference: external_video['_id'])
      video.update(
        title: external_video['title'],
        subscription: external_video['subscription_required'],
        image: external_video['thumbnails'][0]['url'],
        embed_player: video.make_embed_player_url
      ) 
    end
  end

  def make_embed_player_url
    "https://player.zype.com/embed/#{external_reference}.js?autoplay=true&app_key=#{app_key}"
  end

  def entitled_embed_player
    "https://player.zype.com/embed/#{external_reference}.js?autoplay=true&access_token=#{access_token}"
  end
end
