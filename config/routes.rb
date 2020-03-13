Rails.application.routes.draw do

  root 'home#index'

  devise_for :users, controllers: {
  	registrations: 'users/registrations',
  	sessions: 'users/sessions'
  }

  resources :users, only: [:show]
  resources :ingredients, only: [:index, :create]
  resources :recipes, only: [:index, :new, :create, :show, :edit, :update]
  resources :categories, only: [:index]
  resources :menus, only: [:index, :create]

  get '/search', to: 'recipes#search', as: 'search'
end
