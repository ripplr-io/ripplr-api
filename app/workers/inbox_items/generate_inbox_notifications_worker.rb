module InboxItems
  class GenerateInboxNotificationsWorker < ApplicationWorker
    def perform(inbox_item_id)
      inbox_item = InboxItem.find_by(id: inbox_item_id)
      return if inbox_item.blank?

      inbox_item.inbox.inbox_channels.each do |inbox_channel|
        inbox_notification = inbox_channel.inbox_notifications.create(inbox_item: inbox_item)

        InboxNotifications::ScheduleWorker.perform_async(inbox_notification.id)
      end
    end
  end
end
