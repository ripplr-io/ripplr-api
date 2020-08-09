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

    resources :levels, only: :index
    resources :topics, only: :index
    resources :posts
  end
end
