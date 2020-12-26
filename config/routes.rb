Rails.application.routes.draw do
  mount ActionCable.server, at: "/cable"
  mount Sidekiq::Web, at: '/sidekiq'
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?

  # API
  defaults format: :json do
    root to: 'welcome#status'
    post :subscribe, to: 'welcome#subscribe'

    use_doorkeeper do
      skip_controllers :authorizations, :applications, :authorized_applications, :token_info
      controllers tokens: 'doorkeeper/extended_tokens'
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
      resource :marketing, only: :update, controller: :marketing
      resource :onboard, only: :update, controller: :onboard
      resource :password, only: :update, controller: :password
      resource :profile, only: :update, controller: :profile
    end

    resources :bookmarks, only: [:create, :update, :destroy]
    resources :bookmark_folders, path: :folders
    resources :devices, only: [:index, :create, :update, :destroy]
    resource :feed, only: :show
    resources :follows, only: [:index, :create, :destroy]
    resource :inbox, only: :show, controller: :inbox, as: :main_inbox
    resources :inboxes
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
      resources :comments
      resources :ratings, only: [:create], path: :rate
      resources :reports, only: :create

      collection do
        resource :preview, only: :create, module: :posts, as: :posts_previews
      end
    end

    get :search, to: 'search#index'

    resources :topics, only: :index do
      resources :posts, only: :index
    end

    resource :track, only: :create, controller: :track

    resources :users, only: :show do
      resources :followers, only: :index
      resources :follows, only: :index
      resources :posts, only: :index
    end

    namespace :stripe do
      resource :checkout_session, only: :create
      resource :customer_portal, only: :create
      resource :webhook, only: :create
      resources :plans, only: :index
    end
  end

  draw :app
  draw :active_storage
end
