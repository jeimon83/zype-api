# frozen_string_literal: true

# Videos Controller Class
class VideosController < ApplicationController
  before_action :video_path, only: %i[index show]

  def index
    search_result = zype_client.search_videos(params[:page])
    @videos       = search_result.first
    @pagination   = search_result.last
  end

  def show
    @video = zype_client.fetch_video(params[:id])
    return redirect_to login_path if @video[:subscription] && login_required

    @entitled = zype_client.validate_consumer(params[:id]) if @video[:subscription]
  end

  private

  def zype_client
    @zype_client ||= Zype::Client.new
  end

  def video_path
    session[:video_path] = request.env['PATH_INFO']
  end
end
