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

  def validate_token
    Rails.cache.fetch("zype_access_token", expires_in: 1.hour) do
      return false
    end    
  end
end
