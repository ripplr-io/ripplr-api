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
      posts_today = @resource.author.posts.where(
        created_at: Time.current.beginning_of_day..Time.current.end_of_day
      ).count

      posts_today >= @resource.author.level.subscriptions
    end
  end
end
