# frozen_string_literal: true

module Zype
  class Consumer < Oauth
    def validate_consumer(video_id)
      response = Typhoeus.get(entitled_url(video_id), params: { access_token: @access_token} )
      JSON.parse(response.response_body.to_s)
    end

    private

    def entitled_url(video_id)
      "#{Rails.configuration.zype_base_url}/videos/#{video_id}/entitled"
    end
  end
end