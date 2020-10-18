# frozen_string_literal: true

class ZypeVideoFetcherWorker
  include Sidekiq::Worker
  sidekiq_options retry: false
  sidekiq_options queue: :videos

  def perform
    Zype::Client.new.fetch_and_save_videos
  end
end
