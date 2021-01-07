module InboxNotifications
  class DeliverManagerHourlyWorker < ApplicationWorker
    def perform
      inbox_notification_ids = InboxNotification.where(
        scheduled_to: Time.current.beginning_of_hour..Time.current.end_of_hour,
        delivered_at: nil
      ).pluck(:id)

      inbox_notification_ids.each do |inbox_notification_id|
        InboxNotifications::DeliverWorker.perform_async(inbox_notification_id)
      end
    end
  end
end
