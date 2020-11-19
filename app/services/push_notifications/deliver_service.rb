module PushNotifications
  class DeliverService
    include Rails.application.routes.url_helpers

    def initialize(push_notification)
      @push_notification = push_notification
      @notification = build_notification
    end

    def deliver
      OneSignal.send_notification(@notification)
      true
    rescue OneSignal::Client::ApiError => e
      Rails.logger.error "OneSignal failed to deliver with error: #{e}"
      Raven.capture_exception e
      false
    end

    private

    def build_notification
      headings = OneSignal::Notification::Headings.new(en: @push_notification.title)
      contents = OneSignal::Notification::Contents.new(en: @push_notification.body)
      attachments = OneSignal::Attachments.new(url: app_post_url(@push_notification.post))
      included_targets = OneSignal::IncludedTargets.new(include_player_ids: [@push_notification.device.onesignal_id])

      OneSignal::Notification.new(
        headings: headings,
        contents: contents,
        attachments: attachments,
        included_targets: included_targets
      )
    end
  end
end
