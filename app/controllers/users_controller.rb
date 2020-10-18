# frozen_string_literal: true

# Users Controller Class
class UsersController < ApplicationController
  def login; end

  def authenticate
    auth = zype_client.authenticate(login_params)

    if !auth
      redirect_to login_path
    else
      redirect_to session[:video_path]
    end
  end

  private

  def zype_client
    @zype_client ||= Zype::Client.new
  end

  def login_params
    params.permit(:username, :password)
  end
end
