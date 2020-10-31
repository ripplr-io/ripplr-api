module Comments
  class CreateService < Resources::CreateService
    def initialize(attributes)
      super(Comment.new(attributes))
    end

    def save
      success = @resource.save
      Comments::GenerateNotificationsWorker.perform_async(@resource.id) if success
      success
    end
  end
end
