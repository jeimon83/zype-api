# frozen_string_literal: true

# Application Helper
module ApplicationHelper
  def token_missing?
    return false if Rails.cache.read('access_token').present?
    return true  if Rails.cache.read('access_token').nil?
  end

  def app_key
    Rails.configuration.zype_app_key
  end

  def access_token
    Rails.cache.read('access_token')
  end
end
