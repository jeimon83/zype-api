# frozen_string_literal: true

class VideosController < ApplicationController
  before_action :set_zype_client, only: [:index, :show]

  def index
    query_result = @zype.search_videos(params[:page] || 1)
    @videos      = @zype.build_videos_data(query_result['response'])
    @pagination  = @zype.pagination(query_result['pagination'])
  end

  def show
    query_result = @zype.fetch_video(params[:id])
    @video       = @zype.build_video_data(query_result['response'])
  end

  private

  def set_zype_client
    @zype = Zype::Client.new
  end
end
