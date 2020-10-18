# frozen_string_literal: true

# Application Controller Class
class ApplicationController < ActionController::Base

  private

  def login_required
    Rails.cache.fetch('access_token', expires_in: 1.hour) { return true }
    false
  end
end
