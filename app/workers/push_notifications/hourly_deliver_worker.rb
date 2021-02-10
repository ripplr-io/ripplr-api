# TODO: Remove after the Inboxes are shipped
module PushNotifications
  class HourlyDeliverWorker < ApplicationWorker
    def perform
      notification_ids = PushNotification.where(
        scheduled_to: Time.current.beginning_of_hour..Time.current.end_of_hour,
        delivered_at: nil
      ).pluck(:id)

      notification_ids.each do |notification_id|
        PushNotifications::DeliverWorker.perform_async(notification_id)
      end
    end
  end
end
