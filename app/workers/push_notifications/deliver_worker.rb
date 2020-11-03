module PushNotifications
  class DeliverWorker
    include Sidekiq::Worker

    def perform(push_notification_id)
      push_notification = PushNotification.find_by(id: push_notification_id)
      return if push_notification.blank? || push_notification.delivered_at?
      return if push_notification.scheduled_to > Time.current

      deliver_service = PushNotifications::DeliverService.new(push_notification)
      push_notification.touch(:delivered_at) if deliver_service.deliver
    end
  end
end
