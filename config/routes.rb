Rails.application.routes.draw do
  mount ActionCable.server, at: "/cable"
  mount Sidekiq::Web, at: '/sidekiq'

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

    resource :account, only: [:show, :update, :destroy], controller: :account do
      scope module: :account do
        resource :marketing, only: :update, controller: :marketing
        resource :onboard, only: :update, controller: :onboard
        resource :password, only: :update, controller: :password
        resource :profile, only: :update, controller: :profile
      end
    end

    namespace :explore do
      resources :communities, only: :index
    end

    resources :bookmarks, only: [:create, :update, :destroy]
    resources :bookmark_folders, path: :folders
    resources :channels, only: [:index, :create, :update, :destroy]
    resource :feed, only: :show
    resources :follows, only: [:index, :create, :destroy]
    resources :levels, only: :index
    resources :referrals, only: [:index, :show, :create, :destroy]
    resources :subscriptions, only: [:index, :create, :update, :destroy]
    resources :tickets, only: :create

    resources :communities, only: [:show, :create, :update, :destroy] do
      resources :posts, only: :index
    end

    resources :hashtags, only: [:index, :show] do
      resources :posts, only: :index
    end

    resources :inboxes do
      resources :inbox_items, only: :index
      resources :subscription_inboxes, only: :index
    end

    resources :inbox_items, only: [] do
      scope module: :inbox_items do
        resource :archive, only: :update, controller: :archive
      end
    end

    resources :inbox_channels, only: [:create, :update, :destroy]

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

    namespace :support do
      resource :content_suggestions, only: :create
    end

    resources :topics, only: :index do
      resources :posts, only: :index
      resources :communities, only: :index
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
