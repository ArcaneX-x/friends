Rails.application.routes.draw do
  resources :photos
  scope "(:locale)", locale: /#{I18n.available_locales.join("|")}/ do
    root "events#index"
    devise_for :users

    resources :preferences, only: [:update]
    resources :events do
      resources :comments, only: [:create, :destroy]
      resources :subscriptions, only: [:create, :destroy]
      resources :photos, only: [:create, :destroy]
    end
    resources :users, only: [:show, :edit, :update]
  end
end
