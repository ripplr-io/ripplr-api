module Comments
  class CreateService < Resources::BaseService
    def save
      success = @resource.save
      if success
        Comments::GenerateNotificationsWorker.perform_async(@resource.id)
        Mixpanel::TrackCommentCreatedWorker.perform_async(@resource.id)
      end
      success
    end
  end
end
