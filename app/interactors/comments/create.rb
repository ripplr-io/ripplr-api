module Comments
  class Create < ApplicationInteractor
    def call
      context.resource.author ||= context.resource.profile.user

      context.fail! unless context.resource.save

      Comments::GenerateNotificationsWorker.perform_async(context.resource.id)
      Trackers::TrackCommentCreatedWorker.perform_async(context.resource.id)
    end
  end
end
