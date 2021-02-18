module InboxNotifications
  class DeliverToDeviceService
    include Rails.application.routes.url_helpers

    def initialize(inbox_notification)
      @inbox_notification = inbox_notification
      @notification = build_notification
    end

    def deliver
      OneSignal.send_notification(@notification)
      @inbox_notification.update(delivered_at: Time.current)
    rescue OneSignal::Client::ApiError => e
      Rails.logger.error "OneSignal failed to deliver with error: #{e}"
      Raven.capture_exception e
    end

    private

    def build_notification
      headings = OneSignal::Notification::Headings.new(en: title)
      contents = OneSignal::Notification::Contents.new(en: post.body)
      attachments = OneSignal::Attachments.new(url: app_post_url(post))
      included_targets = OneSignal::IncludedTargets.new(include_player_ids: [device.onesignal_id])

      OneSignal::Notification.new(
        headings: headings,
        contents: contents,
        attachments: attachments,
        included_targets: included_targets
      )
    end

    def device
      @inbox_notification.inbox_channel.channel.channel_device
    end

    def post
      @inbox_notification.inbox_item.inboxable
    end

    def title
      "#{post.author.name} has shared a new post"
    end
  end
end
