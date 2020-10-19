# frozen_string_literal: true

# Application Controller Class
class ApplicationController < ActionController::Base

  private

  def login_required
    return true if Rails.cache.read(session[:email]).nil?

    false
  end

  def access_token
    Rails.cache.read(session[:email])
  end
end
