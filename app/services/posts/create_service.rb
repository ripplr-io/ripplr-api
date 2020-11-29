require 'open-uri'

module Posts
  class CreateService < Resources::BaseService
    def initialize(resource, image_url: nil)
      super(resource)
      attach_from_url(image_url) if image_url.present?
    end

    def save
      if above_level_limit?
        @resource.errors.add(:max_posts, 'limit reached')
        return false
      end

      success = @resource.save
      if success
        Posts::PushNotifications::GenerateWorker.perform_async(@resource.id)
        Posts::BroadcastCreationWorker.perform_async(@resource.id)
        Mixpanel::TrackPostCreatedWorker.perform_async(@resource.id)
      end
      success
    end

    private

    def above_level_limit?
      @resource.author.posts_today >= @resource.author.level.subscriptions
    end

    def attach_from_url(image_url)
      return if @resource.image.attached?

      uri = URI.parse(image_url)
      file = uri.open
      filename = File.basename(uri.path)
      @resource.image.attach(io: file, filename: filename)
    end
  end
end
