Rails.application.routes.draw do
  devise_for :users

  root to: "home#index"
  resources :posts
  resources :friendships do
    put :confirm
  end
  resources :friend_requests do
    put :confirm
  end
  resources :friends_list
end
