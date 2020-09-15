require 'sidekiq/web'

Rails.application.routes.draw do
  # TODO: Add authentication to sidekiq routes
  mount Sidekiq::Web, at: '/sidekiq'

  # API
  defaults format: :json do
    devise_for :users, path: 'auth', path_names: {
      sign_in: :login,
      sign_out: :logout,
      registration: :signup
    }, controllers: {
      sessions: :sessions,
      registrations: :registrations
    }

    scope :auth do
      get :user, to: 'users#legacy_show'
      resources :users
    end

    resources :devices, only: [:index, :create, :update, :destroy]
    resources :follows, only: [:index, :create]

    resources :hashtags, only: :show do
      resources :posts, only: :index
    end

    resources :levels, only: :index

    resources :notifications, only: :index do
      put :read, on: :member
      post :read, on: :collection, to: 'notifications#read_all'
    end

    resources :posts, only: [:create, :update, :destroy] do
      resources :comments, only: [:index, :show, :create]
      resources :ratings, only: [:create], path: :rate
    end

    resource :feed, only: :show

    resources :topics, only: :index do
      resources :posts, only: :index
    end

    resources :users, only: :show do
      resources :posts, only: :index
    end
  end
end
