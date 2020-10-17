module ApplicationHelper
  def token_missing?
    return false if Rails.cache.read("access_token").present?
    return true  if Rails.cache.read("access_token").nil?
  end
end
