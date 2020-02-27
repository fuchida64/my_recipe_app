Rails.application.routes.draw do

  get 'categories/index'
  root 'home#index'

  devise_for :users, controllers: {
  	registrations: 'users/registrations',
  	sessions: 'users/sessions'
  }

  resources :users, only: [:show]
  resources :ingredients, only: [:index, :create]
  resources :recipes, only: [:index, :new, :create, :show]
  resources :categories, only: [:index]
end
