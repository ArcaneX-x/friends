Rails.application.routes.draw do
  devise_for :users
  root "events#index"
  resources :events
    # resources :comments, only: [:create, :destroy]
  # end
  resources :users, only: [:show, :edit, :update]
end
