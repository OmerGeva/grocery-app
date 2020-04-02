Rails.application.routes.draw do
  devise_for :users
  root to: 'supermarkets#index'

  resources :supermarkets, only: [:show] do
    patch :search, to: 'supermarkets#update_searched_word'
  end

  resources :customers, only: [:new, :create]
  resources :delivery_users, only: [:new, :create]
  resources :orders, only: [:show, :create, :update]

  resources :items, only: [:index]



########################## API ROUTES ##########################
  namespace :api, defaults: { format: :json } do
    namespace :v1 do

      root to: 'supermarkets#index'
      resources :supermarkets, only: [:show] do
        patch :search, to: 'supermarkets#update_searched_word'
      end

      resources :customers, only: [:new, :create]
      resources :delivery_users, only: [:new, :create]
      resources :orders, only: [:show, :create, :update]

      resources :items, only: [:index]

    end
  end
end
