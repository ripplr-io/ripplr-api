Raven.configure do |config|
  config.dsn = Rails.application.credentials.dig(:sentry_dsn)
end
