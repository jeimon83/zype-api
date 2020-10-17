# frozen_string_literal: true

class VideosController < ApplicationController
  before_action :video_path, only: :show

  def index
    query_result = zype_client.search_videos(params[:page])
    @videos      = zype_client.build_videos_data(query_result['response'])
    @pagination  = paginate(query_result['pagination'])
  end

  def show
    @video = zype_client.fetch_video(params[:id])
    return redirect_to login_path if @video[:subscription] && login_required

    @entitled = zype_client.validate_consumer(params[:id]) if @video[:subscription]
  end

  private

  def zype_client
    @zype ||= Zype::Client.new
  end

  def video_path
    session[:video_path] = request.env['PATH_INFO']
  end
end
