# frozen_string_literal: true

module Zype
  class Api < Base
    def authenticate
      Zype::Oauth.new.authenticate
    end

    def videos
      Zype::Videos.new.list_videos
    end
  end
end