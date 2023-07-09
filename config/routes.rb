Rails.application.routes.draw do
  devise_for :users

  root :to => 'homes#top'
  get '/about' => 'homes#about', as: 'about'

  resources :users, only: [:show, :edit, :update, :unsubscribe, :withdraw] do
    resource :relationships, only: [:create, :destroy]
    get 'followings' => 'relationships#followings', as: 'followings'
    get 'followers' => 'relationships#followers', as: 'followers'
  end

  resources :want_clothes, only: [:index, :edit, :create, :update, :destroy] do
    resources :want_answers, only: [:create, :destroy]
  end

  resources :recommends, only: [:index, :new, :edit, :create, :update, :destroy] do
    resource :favorites, only: [:create, :destroy]
  end

  resources :genres, only: [:create, :update, :destroy]

  resources :rooms, only: [:index]
  resources :letters, only: [:show, :create]

  get '/search', to: 'searches#search'
end
