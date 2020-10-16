Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'videos#index'
  resources :videos, only: %i[index show] do
    get  :auth,  on: :member
    post :login, on: :member
  end
end
