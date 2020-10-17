class UsersController < ApplicationController
  def login
    session[:video_path] = nil if params[:header]
  end

  def authenticate
    auth = zype_client.authenticate(login_params)

    if !auth
      return redirect_to login_path
    elsif session[:video_path].present?
      return redirect_to session[:video_path] 
    end

    redirect_to videos_path
  end

  def logout
    delete_access_token
    redirect_to videos_path
  end

  private

  def zype_client
    @zype ||= Zype::Client.new
  end

  def login_params
    params.permit(:username, :password)
    { username: params[:username], password: params[:password] }
  end
end
