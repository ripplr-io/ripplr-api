require 'sidekiq/web'

Rails.application.routes.draw do
  # TODO: Add authentication to sidekiq routes
  mount Sidekiq::Web, at: '/sidekiq'
end
