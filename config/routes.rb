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
      resource :onboard, only: :update, controller: :onboard
      resource :password, only: :update, controller: :password
      resource :profile, only: :update, controller: :profile
    end

    resources :bookmarks, only: [:create, :update, :destroy]
    resources :bookmark_folders, path: :folders
    resources :devices, only: [:index, :create, :update, :destroy]
    resource :feed, only: :show
    resources :followers, only: :index
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

  # FIXME: Rails will have a CDN proxy in a future version: https://github.com/rails/rails/pull/34477
  # In the meantime we're using this solution: https://lipanski.com/posts/activestorage-cdn-rails-direct-route
  direct :public_blob do |blob|
    if Rails.env.development? || Rails.env.test?
      route_for(:rails_blob, blob)
    else
      File.join("https://cdn.ripplr.io", blob.key)
    end
  end

  direct :app_post do |post|
    base_url = Rails.application.credentials[:web_app_url]
    "#{base_url}/p/#{post.id}"
  end
end
