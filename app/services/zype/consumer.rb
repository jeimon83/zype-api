# frozen_string_literal: true

module Zype
  class Consumer < Oauth
    def validate_consumer(video_id)
      request = Typhoeus::Request.new(
        entitled_url(video_id),
        method: :get,
        params: @credentials['access_token'],
      )
    
      response = request.run
      JSON.parse(response.response_body.to_s)
    end

    private

    def entitled_url(video_id)
      "#{Rails.configuration.zype_base_url}/videos/#{video_id}/entitled"
    end
  end
end