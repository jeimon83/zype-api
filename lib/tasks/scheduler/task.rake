namespace :scheduler do
  desc 'Fetch videos from Zype Api every hour'
  task fetch_videos_from_zype: :environment do
    puts "Starting Zype video fetcher worker"
    ZypeVideoFetcherWorker.new.perform
    puts "Zype video fetcher DONE"
  end
end