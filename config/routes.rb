Rails.application.routes.draw do
  root "landing#index"
  devise_for :users

  resources :users, only: [:show]
  resources :friendships
end
