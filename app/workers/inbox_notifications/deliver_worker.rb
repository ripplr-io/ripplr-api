module InboxNotifications
  class DeliverWorker < ApplicationWorker
    def perform(inbox_notification_id)
      inbox_notification = InboxNotification.find_by(id: inbox_notification_id)
      return if inbox_notification.blank? || inbox_notification.delivered_at?
      return if inbox_notification.scheduled_to > Time.current

      deliver_service = InboxNotifications::DeliverService.new(inbox_notification)
      inbox_notification.touch(:delivered_at) if deliver_service.deliver
    end
  end
end
