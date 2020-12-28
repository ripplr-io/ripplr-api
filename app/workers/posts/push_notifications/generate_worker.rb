module Posts
  module PushNotifications
    class GenerateWorker < ApplicationWorker
      def perform(post_id)
        post = Post.find_by(id: post_id)
        return if post.blank?

        post.subscriptions.each do |subscription|
          subscription.devices.each do |device|
            GenerateForDeviceWorker.perform_async(post.id, subscription.id, device.id)
          end
        end
      end
    end
  end
end
