require 'sidekiq/web'
require 'sidekiq-scheduler/web'

Rails.application.routes.draw do
  mount ActionCable.server, at: "/cable"
  # TODO: Add authentication to sidekiq routes
  mount Sidekiq::Web, at: '/sidekiq'
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?

  # API
  defaults format: :json do
    root to: 'welcome#status'
    post :subscribe, to: 'welcome#subscribe'

    use_doorkeeper do
      skip_controllers :authorizations, :applications, :authorized_applications, :token_info
    end

    devise_for :users, skip: :all
    namespace :auth do
      devise_scope :user do
        post :register, to: 'registrations#create'
        post :password, to: 'passwords#create'
        put :password, to: 'passwords#update'
      end
    end

    resource :account, only: [:show, :update, :destroy], controller: :account
    namespace :account do
      resource :password, only: :update, controller: :password
      resource :profile, only: :update, controller: :profile
      resource :onboard, only: :update, controller: :onboard
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

    resources :hashtags, only: [:index, :show] do
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
