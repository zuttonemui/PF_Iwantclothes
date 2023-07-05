Rails.application.routes.draw do
  get 'letters/show'
  get 'rooms/index'
  get 'relationships/followings'
  get 'relationships/followers'
  get 'recommends/index'
  get 'recommends/new'
  get 'recommends/edit'
  get 'want_clothes/index'
  get 'want_clothes/new'
  get 'want_clothes/edit'
  get 'users/show'
  get 'users/ed'
  get 'homes/top'
  get 'homes/about'
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
