module InboxNotifications
  class DeliverService
    def initialize(inbox_notification)
      @inbox_notification = inbox_notification
    end

    def deliver
      return DeliverToDeviceService.new(@inbox_notification).deliver if @inbox_notification.channel.channel_device?

      # TODO: return DeliverToEmailService.new(@inbox_notification).deliver if @inbox_notification.channel.channel_email?

      false
    end
  end
end
