Rails.application.routes.draw do
  get 'reviews/create'

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks" }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: "home#index"
  resources :orders, only: [:show, :index]
  resources :positions, only: [:create, :update, :destroy]
  resources :billing_addresses, only: [:create, :update]
  resources :shipping_addresses, only: [:create, :update]
  resources :reviews, only: :create
  resource :cart, only: :show
  resources :books
  resources :categories do
    resources :books, only: :index
  end
  resources :checkout

  put '/users/edit_email/:id', to: 'users#update_email'
  put '/coupons/link_order', to: 'coupons#link_order'
end
