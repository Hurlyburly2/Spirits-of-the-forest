Rails.application.routes.draw do
  root 'homes#index'
  devise_for :users
  
  resources :users, only: [:index]
  
  namespace :api do
    namespace :v1 do
      resources :games, only: [:index]
    end
  end
end
