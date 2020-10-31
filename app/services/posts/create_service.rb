module Posts
  class CreateService < Resources::CreateService
    def initialize(attributes)
      super(Post.new(attributes))
    end

    def save
      success = @resource.save
      if success
        Posts::PushNotifications::GenerateWorker.perform_async(@resource.id)
        Posts::BroadcastCreationWorker.perform_async(@resource.id)
      end
      success
    end
  end
end
