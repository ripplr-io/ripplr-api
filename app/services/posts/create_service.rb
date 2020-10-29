module Posts
  class CreateService < Resources::CreateService
    def initialize(attributes)
      super(Post.new(attributes))
    end

    def save
      success = @resource.save
      Posts::GeneratePushNotificationsWorker.perform_async(@resource.id) if success
      success
    end
  end
end
