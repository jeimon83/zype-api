# frozen_string_literal: true

# Application Helper
module ApplicationHelper
  def token_missing?
    return false if Rails.cache.read(session[:email]).present?
    
    true
  end
end
