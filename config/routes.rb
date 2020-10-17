Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'videos#index'
  resources :videos, only: %i[index show]

  get '/login',         to: "users#login"
  get '/logout',        to: "users#logout"
  post '/authenticate', to: "users#authenticate"
  
end
