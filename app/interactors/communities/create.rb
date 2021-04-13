module Communities
  class Create < ApplicationInteractor
    REQUIRED_POINTS = 1000

    # TODO: move to validator
    before :validate_user_points

    def call
      context.fail! unless context.resource.save

      Segment::TrackCommunityCreatedWorker.perform_async(context.resource.id)
    end

    private

    def validate_user_points
      return if context.resource.owner.total_points >= REQUIRED_POINTS

      context.resource.errors.add(:total_points, 'below required amount')
      context.fail!
    end
  end
end
