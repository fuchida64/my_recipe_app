Rails.application.routes.draw do

  root 'home#index'

  devise_for :users, controllers: {
  	registrations: 'users/registrations',
  	sessions: 'users/sessions'
  }

  resources :users, only: [:show]
end
