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
      resource :profile, only: :update
    end

    resources :bookmarks, only: [:index, :create, :update, :destroy]
    resources :bookmark_folders, path: :folders, only: [:create, :update, :destroy]
    resources :devices, only: [:index, :create, :update, :destroy]
    resource :feed, only: :show
    resources :follows, only: [:index, :create]
    resources :levels, only: :index
    resources :referrals, only: [:index, :create, :destroy]
    resources :subscriptions, only: [:index, :create, :update, :destroy]
    resources :tickets, only: :create

    resources :hashtags, only: :show do
      resources :posts, only: :index
    end

    resources :notifications, only: :index do
      put :read, on: :member
      post :read, on: :collection, to: 'notifications#read_all'
    end

    resources :posts, only: [:create, :update, :destroy] do
      resources :comments, only: [:index, :show, :create]
      resources :ratings, only: [:create], path: :rate

      post :preview, on: :collection
    end

    resources :topics, only: :index do
      resources :posts, only: :index
    end

    resources :users, only: :show do
      resources :posts, only: :index
    end
  end
end
