module Communities
  class Create < ApplicationInteractor
    def call
      context.fail! unless context.resource.save

      Trackers::TrackCommunityCreatedWorker.perform_async(context.resource.id)
    end
  end
end
