class ApiMailer
  include Sidekiq::Worker
  include Sendgrid::Mailer
  include Rails.application.routes.url_helpers

  sidekiq_options queue: :mailers, retry: false

  from 'support@ripplr.io'
end
