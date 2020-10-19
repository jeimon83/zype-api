# frozen_string_literal: true

# Module Zype
module Zype
  # Class Consumer
  class Consumer
    def validate_entitlement(id, access_token)
      response = Typhoeus.get(entitled_url(id), params: { access_token: access_token })
      message = JSON.parse(response.response_body.to_s)['message']
      return true if message == 'entitled'
    end

    private

    def entitled_url(id)
      "#{Rails.configuration.zype_base_url}/videos/#{id}/entitled"
    end
  end
end
