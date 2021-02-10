# TODO: Remove after the Inboxes are shipped
module Posts
  module PushNotifications
    class GenerateForDeviceWorker < ApplicationWorker
      def perform(post_id, subscription_id, device_id)
        # FIXME: Add index?
        push_notification = PushNotification.find_by(
          post_id: post_id,
          subscription_id: subscription_id,
          device_id: device_id
        )
        return if push_notification.present?

        @post = Post.find_by(id: post_id)
        @subscription = Subscription.find_by(id: subscription_id)
        @device = Device.find_by(id: device_id)
        return unless @post.present? && @subscription.present? && @device.present?

        create_push_notification
      end

      def create_push_notification
        settings = ::PushNotifications::SettingsService.new(@post, @subscription, @device)
        return unless settings.topic_subscribed?

        next_slot = settings.next_available_slot
        return if next_slot.blank?

        push_notification = @device.push_notifications.create!(
          post: @post,
          subscription: @subscription,
          title: "#{@post.author.name} has shared a new post",
          body: @post.body,
          thumbnail: 'https://ripplr.ams3.digitaloceanspaces.com/brand/logo-black.png',
          scheduled_to: next_slot
        )

        ::PushNotifications::DeliverWorker.perform_async(push_notification.id)
      end
    end
  end
end
