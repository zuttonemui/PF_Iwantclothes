Rails.application.routes.draw do
  devise_for :users

  devise_scope :user do
    post "users/guest_sign_in", to: "users/sessions#guest_sign_in"
  end

  root :to => 'homes#top'
  get '/about' => 'homes#about', as: 'about'

  resources :users, only: [:show, :edit, :update] do
    resource :relationships, only: [:create, :destroy]
    get 'followings' => 'relationships#followings', as: 'followings'
    get 'followers' => 'relationships#followers', as: 'followers'
    member do
      get :favorites
    end
    get 'unsubscribe' => 'users#unsubscribe', as: 'unsubscribe'
    patch 'withdraw' => 'users#withdraw', as: 'withdraw'
  end

  resources :notifications, only: :index

  resources :want_items, only: [:index, :create, :update, :destroy] do
    resources :want_answers, only: [:create, :destroy]
  end

  resources :recommends, only: [:index, :new, :edit, :create, :update, :destroy] do
    resource :favorites, only: [:create, :destroy]
  end

  resources :categories, only: [:create, :destroy]
  resources :category_groups, only: [:create, :destroy]

  resources :rooms, only:[:index]
  resources :letters, only: [:show, :create]

  get '/search', to: 'searches#search'
end
