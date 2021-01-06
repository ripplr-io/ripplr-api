module InboxNotifications
  class ScheduleWorker < ApplicationWorker
    def perform(inbox_notification_id)
      inbox_notification = InboxNotification.find_by(id: inbox_notification_id)
      return if inbox_notification.blank?

      next_slot = InboxNotifications::ScheduleService.new(inbox_notification).next_available_slot
      inbox_notification.update(scheduled_to: next_slot)
    end
  end
end
