# frozen_string_literal: true

# Videos Controller Class
class VideosController < ApplicationController
  before_action :video_path, only: %i[index show]

  def index
    @videos = Video.paginate(page: params[:page])
  end

  def show
    video = Video.find(params[:id])
    return redirect_to login_path if video.subscription && login_required

    entitled = zype_client.validate_consumer(video.external_reference) if video.subscription
    entitled_embed_player = video.entitled_embed_player if entitled

    @subscription = video.subscription
    @video_id = video.external_reference
    @embed_player = entitled_embed_player.presence || video.embed_player
  end

  private

  def zype_client
    @zype_client ||= Zype::Client.new
  end

  def video_path
    session[:video_path] = request.env['PATH_INFO']
  end
end
