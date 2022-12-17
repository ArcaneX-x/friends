Rails.application.routes.draw do
  root "events#index"
  devise_for :users

  resources :settings
  resources :events do
    resources :comments, only: [:create, :destroy]
    resources :subscriptions, only: [:create, :destroy]
  end
  resources :users, only: [:show, :edit, :update]
end
