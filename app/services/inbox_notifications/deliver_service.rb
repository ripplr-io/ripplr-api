module InboxNotifications
  class DeliverService
    def initialize(inbox_notification)
      @inbox_notification = inbox_notification
      @channel = inbox_notification.channel
    end

    def deliver
      DeliverToDeviceService.new(@inbox_notification).deliver if @channel.channel_device?
      InboxNotifications::DeliverMailer.perform_async(@inbox_notification.id) if @channel.channel_email?
    end
  end
end
