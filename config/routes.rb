Rails.application.routes.draw do
  root 'homes#index'
  devise_for :users
  
  resources :users, only: [:index]
  
  resources :games, only: [:create]
  
  resources :matches, only: [:index]
  
  namespace :api do
    namespace :v1 do
      resources :games, only: [:index, :create]
      resources :matches, only: [:index]
    end
  end
end
