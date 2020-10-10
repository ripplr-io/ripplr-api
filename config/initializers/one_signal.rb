require 'onesignal'

OneSignal.configure do |config|
  config.app_id = Rails.application.credentials.dig(:onesignal, :app_id)
  config.api_key = Rails.application.credentials.dig(:onesignal, :api_key)
end
