# frozen_string_literal: true

class VideosController < ApplicationController
  def index
    query_result = zype_client.search_videos(params[:page])
    @videos      = zype_client.build_videos_data(query_result['response'])
    @pagination  = paginate(query_result['pagination'])
  end

  def show
    query_result = zype_client.fetch_video(params[:id])
    @video       = zype_client.build_video_data(query_result['response'])
    token = validate_token if @video[:subscription]
    redirect_to auth_video_path if !token
  end

  def auth; end

  def login
    x = zype_client.authenticate(params)
    binding.pry
  end

  private

  def zype_client
    @zype ||= Zype::Client.new
  end

  def video_params
    params.permit(:page, :username, :password)
  end

end
