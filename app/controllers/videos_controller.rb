# frozen_string_literal: true

# Videos Controller Class
class VideosController < ApplicationController
  before_action :previous_url, only: %i[index show]
  before_action :set_video, only: :show

  def index
    @videos = Video.paginate(page: params[:page])
  end

  def show
    return redirect_to login_path if @video.subscription && login_required

    entitled = zype_client.validate_entitlement(@video.external_reference, access_token) if @video.subscription
    entitled_embed_player = @video.entitled_embed_player(access_token) if entitled
    @embed_player = entitled_embed_player.presence || @video.embed_player
  end

  private

  def previous_url
    session[:previous_url] = request.env['PATH_INFO']
  end

  def zype_client
    @zype_client ||= Zype::Client.new
  end

  def set_video
    @video = Video.find(params[:id])
  end
end
