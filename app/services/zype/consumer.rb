# frozen_string_literal: true

# Module Zype
module Zype
  # Class Consumer
  class Consumer
    def validate_consumer(video_id)
      response = Typhoeus.get(entitled_url(video_id), params: { access_token: @access_token} )
      message = JSON.parse(response.response_body.to_s)['message']
      return true if message != 'entitled'
    end

    private

    def entitled_url(video_id)
      "#{Rails.configuration.zype_base_url}/videos/#{video_id}/entitled"
    end
  end
end
