# frozen_string_literal: true

# Users Controller Class
class UsersController < ApplicationController
  def api_login; end

  def authenticate
    auth = zype_client.authenticate(login_params)

    if !auth
      redirect_to api_login_path
    else
      redirect_to session[:video_path]
    end
  end

  def logout
    delete_access_token
    redirect_to session[:video_path]
  end

  private

  def zype_client
    @zype_client ||= Zype::Client.new
  end

  def login_params
    params.permit(:username, :password)
    { username: params[:username], password: params[:password] }
  end
end
