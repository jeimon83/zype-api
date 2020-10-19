# frozen_string_literal: true

# Users Controller Class
class UsersController < ApplicationController
  def login; end

  def authenticate
    session[:email] = params[:email]
    auth = zype_client.authenticate(login_params)
    return redirect_to login_path, alert: "Invalid credentials. Please, try again!" if !auth
      
    redirect_to session[:previous_url]
  end

  private

  def zype_client
    @zype_client ||= Zype::Client.new
  end

  def login_params
    params.permit(:email, :password)
  end
end
