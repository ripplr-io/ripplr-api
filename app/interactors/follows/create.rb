module Follows
  class Create < ApplicationInteractor
    def call
      context.fail! unless context.resource.save

      generate_notification
      Segment::TrackFollowCreatedWorker.perform_async(context.resource.id)
      Prizes::Onboarding::FirstFollowWorker.perform_async(context.resource.user.id)
    end

    private

    def generate_notification
      return unless context.resource.followable_type == 'User'

      Notifications::NewFollower.create(user: context.resource.followable, follower: context.resource.user)
    end
  end
end
