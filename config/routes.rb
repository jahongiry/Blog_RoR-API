Rails.application.routes.draw do
  devise_for :users

  namespace :api , defaults: { format: :json } do
    namespace :v1 do
      post 'users/sign_up' => 'users#register'
      post 'users/sign_in' => 'users#login'
      get 'posts' => 'posts#index'
      get 'comments' => 'comments#index'
      post 'comments/create' => 'comments#create'
    end
  end

  devise_scope :user do get '/users/sign_out' => 'devise/sessions#destroy' end

  resources :users, only: [:index, :show] do
    resources :posts, only: [:index, :show, :create, :new, :destroy] do
      resources :comments, only: [:create, :new, :destroy]
      resources :likes, only: [:create]
    end
  end

  root "users#index"
end
