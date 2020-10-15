# frozen_string_literal: true

module Zype
  class Base

    def perform_request(request)
      @response = request.run
      return if @response.success?

      @response = handle_request_error(reques, @response)
    end

    def handle_request_error(request, response)
      case response.code
      when 401, 403 then return
      # Temporal errors: Optimistic Locking and 500
      when 409, 500, 501, 502, 504
        response.body = response.body.presence || 'empty'
        raise "Error #{responde.code} - Response: #{response.body}"
      else
        raise "Failed to #{request.options[:method]} to #{request.url}"
      end      
    end

  end
end
    