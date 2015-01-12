Rails.application.routes.draw do
  resources :game_lists

  resources :purchase_items

  resources :cart_items

  resources :purchases

  resources :carts

  resources :messages

  resources :ratings

  resources :comments

  resources :games

  resources :sessions, only: [:new, :create, :destroy]

  resources :users, only: [:new, :create, :destroy] do
    member do
      post 'activation'
    end
  end

  root to: 'static_pages#home'

  match '/register', to: 'users#new', via: [:get, :post]
  match '/signin', to: 'sessions#new', via: [:get, :post]
  match '/signout', to: 'sessions#destroy', via: :delete
  match '/home', to:   'static_pages#home', via: :get
  match '/help', to: 'static_pages#help', via: :get
  match '/profile', to: 'users#show', via: [:post, :get]
  match '/cart', to: 'carts#show', via: [:post, :get]
  match '/activate', to: 'users#activate', via: [:post, :get]
  match '/resend', to: 'users#resend_activation', via: :post
end
