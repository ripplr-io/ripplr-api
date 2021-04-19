module Communities
  class Create < ApplicationInteractor
    def call
      context.fail! unless context.resource.save

      Segment::TrackCommunityCreatedWorker.perform_async(context.resource.id)
    end
  end
end
