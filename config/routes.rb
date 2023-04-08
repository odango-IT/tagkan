Rails.application.routes.draw do
  root 'top#index'
  post 's' => 'top#search'
  get 's/:tags' => 'top#result'
  resources :posts
  get 'tags' => 'tags#index'
  post 'tags' => 'tags#create'
  get 'tags/:id' => 'tags#destroy'

  devise_for :users, skip: :all
  devise_scope :user do
  get 'login' => 'devise/sessions#new', as: :new_user_session
  post 'login' => 'devise/sessions#create', as: :user_session
  delete 'logout' => 'devise/sessions#destroy', as: :destroy_user_session
  get 'signup' => 'devise/registrations#new', as: :new_user_registration
  post 'signup' => 'devise/registrations#create', as: :user_registration
  get 'signup/cancel' => 'devise/registrations#cancel', as: :cancel_user_registration
  get 'user' => 'devise/registrations#edit', as: :edit_user_registration
  patch 'user' => 'devise/registrations#update', as: nil
  put 'user' => 'devise/registrations#update', as: :update_user_registration
  delete 'user' => 'devise/registrations#destroy', as: :destroy_user_registration
  get 'password' => 'devise/passwords#new', as: :new_user_password
  post 'password' => 'devise/passwords#create', as: :user_password
  get 'password/edit' => 'devise/passwords#edit', as: :edit_user_password
  patch 'password' => 'devise/passwords#update'
  put 'password' => 'devise/passwords#update', as: :update_user_password
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
