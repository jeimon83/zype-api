# frozen_string_literal: true

class VideosController < ApplicationController
  def index
    @videos = Zype::Api.new.videos
  end

  def show
    @video = Zype::Videos.find_video_by_id(params[:id])
  end
end
