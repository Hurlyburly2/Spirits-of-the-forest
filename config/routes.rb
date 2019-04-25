Rails.application.routes.draw do
  root 'homes#index'
  devise_for :users
  
  resources :users, only: [:index]
  
  resources :games, only: [:create]
  
  namespace :api do
    namespace :v1 do
      resources :games, only: [:index, :create]
    end
  end
end
