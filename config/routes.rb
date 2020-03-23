Rails.application.routes.draw do

  root 'home#index'

  devise_for :users, controllers: {
  	registrations: 'users/registrations',
  	sessions: 'users/sessions'
  }

  resources :users, only: [:show]
  resources :ingredients, only: [:index, :create]
  resources :recipes, only: [:index, :new, :create, :show, :edit, :update]
  resources :categories, only: [:index, :show]
  resources :menus, only: [:index, :create, :update, :destroy]

  get '/search', to: 'recipes#search', as: 'search'
end
