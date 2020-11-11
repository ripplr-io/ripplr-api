module Posts
  class CreateService < Resources::CreateService
    def initialize(attributes)
      super(Post.new(attributes))
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
      end
      success
    end

    private

    def above_level_limit?
      @resource.author.posts_today >= @resource.author.level.subscriptions
    end
  end
end
