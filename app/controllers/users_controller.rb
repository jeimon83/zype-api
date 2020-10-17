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

  def logout
    delete_access_token
    redirect_to session[:video_path]
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