require 'sidekiq/web'
require 'sidekiq-scheduler/web'

Rails.application.routes.draw do
  # TODO: Add authentication to sidekiq routes
  mount Sidekiq::Web, at: '/sidekiq'
  mount ActionCable.server, at: "/cable"
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?

  # API
  defaults format: :json do
    root to: 'welcome#status'
    post :subscribe, to: 'welcome#subscribe'

    scope :auth do
      devise_for :users, path: '', module: "accounts", sign_out_via: :post, path_names: {
        sign_in: :login,
        sign_out: :logout,
        registration: :register,
        password: 'password/reset'
      }

      resource :account, only: [:update, :destroy]
      resources :users, only: :show
      resource :profile, only: :update
      get :user, to: 'profiles#show'
      get :refresh, to: 'accounts#refresh'
      post :onboard, to: 'accounts#onboard'
    end

    resources :bookmarks, only: [:index, :create, :update, :destroy]
    resources :bookmark_folders, only: [:create, :update, :destroy], path: :folders
    resources :devices, only: [:index, :create, :update, :destroy]
    resource :feed, only: :show
    resources :follows, only: [:index, :create, :destroy]
    resource :inbox, only: :show
    resources :levels, only: :index
    resources :referrals, only: [:index, :show, :create, :destroy]
    resources :subscriptions, only: [:index, :create, :update, :destroy]
    resources :tickets, only: :create

    resources :hashtags, only: :show do
      resources :posts, only: :index
    end

    resources :notifications, only: :index do
      put :read, on: :member
      post :read, on: :collection, to: 'notifications#read_all'
    end

    resources :posts, only: [:show, :create, :update, :destroy] do
      resources :comments, only: [:index, :show, :create]
      resources :ratings, only: [:create], path: :rate

      post :preview, on: :collection
    end

    get :search, to: 'search#index'

    resources :topics, only: :index do
      resources :posts, only: :index
    end

    resources :users, only: :show do
      resources :posts, only: :index
    end
  end
end
