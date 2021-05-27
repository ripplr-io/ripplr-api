module Follows
  class Create < ApplicationInteractor
    def call
      context.fail! unless context.resource.save

      generate_notification
      Trackers::TrackFollowCreatedWorker.perform_async(context.resource.id)
      Prizes::Onboarding::FirstFollowWorker.perform_async(context.resource.user.id)
    end

    private

    def generate_notification
      return unless context.resource.followable_type == 'Profile'

      Notification.create(
        user: context.resource.followable.user,
        notifiable: Notification::NewFollower.new(follow: context.resource)
      )
    end
  end
end
