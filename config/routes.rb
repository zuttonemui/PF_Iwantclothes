Rails.application.routes.draw do
  devise_for :users

  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
  end

  root :to => 'homes#top'

  resources :users, only: [:index, :show, :edit, :update] do
    resource :relationships, only: [:create, :destroy]
    get 'followings' => 'relationships#followings', as: 'followings'
    get 'followers' => 'relationships#followers', as: 'followers'
    member do
      get :favorites
      get :dm
    end
    get 'unsubscribe' => 'users#unsubscribe', as: 'unsubscribe'
    patch 'withdraw' => 'users#withdraw', as: 'withdraw'
  end

  resources :notifications, only: [:index]

  resources :want_items, only: [:index, :create, :update, :destroy] do
    resources :want_answers, only: [:create, :destroy]
    member do
      patch 'answer_close' => 'want_items#answer_close', as: 'answer_close'
    end
  end

  resources :recommends, only: [:index, :new, :create, :update, :destroy] do
    resource :favorites, only: [:create, :destroy]
  end

  resources :categories, only: [:show, :create, :destroy] do
    member do
      get 'want_item' => 'categories#want_item'
      get 'recommend' => 'categories#recommend'
    end
  end

  resources :category_groups, only: [:show, :create, :destroy] do
    member do
      get 'want_item' => 'category_groups#want_item'
      get 'recommend' => 'category_groups#recommend'
    end
  end

  resources :rooms, only: [:index]
  resources :letters, only: [:create]

  get '/search', to: 'searches#search'
end
