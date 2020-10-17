class ApplicationController < ActionController::Base

  private 

  def paginate(data)
    {
      current_page: data['current'],
      next_page: data['next'],
      previous_page: data['previous'],
      total_pages: data['pages']
    }
  end

  def login_required
    Rails.cache.fetch("access_token", expires_in: 1.hour) { return true }
    return false
  end

  def delete_access_token
    Rails.cache.delete("access_token")
  end
end
