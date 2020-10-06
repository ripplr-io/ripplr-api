namespace :notifications do
  desc 'Send notifications for the current hour'
  task send_hourly: :environment do
    PushNotification.where(
      scheduled_to: Time.current.beginning_of_hour..Time.current.end_of_hour,
      delivered_at: nil
    )

    # TODO: Send notifications
  end
end
