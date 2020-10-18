require 'sidekiq/web'

Rails.application.routes.draw do

  scope :monitoring do
    Sidekiq::Web.use Rack::Auth::Basic do |username, password|
      ActiveSupport::SecurityUtils.secure_compare(::Digest::SHA256.hexdigest(username), ::Digest::SHA256.hexdigest(ENV["SIDEKIQ_USERNAME"])) &
      ActiveSupport::SecurityUtils.secure_compare(::Digest::SHA256.hexdigest(password), ::Digest::SHA256.hexdigest(ENV["SIDEKIQ_PASSWORD"]))
    end
  end

  mount Sidekiq::Web => '/sidekiq'

  root to: 'videos#index'
  resources :videos, only: %i[index show]

  get '/login',         to: "users#login"
  post '/authenticate', to: "users#authenticate"
  
end
