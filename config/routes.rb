Rails.application.routes.draw do
  Rails.application.routes.draw do
    root "landing#index"
    devise_for :users

    resources :friendships
  end
end
