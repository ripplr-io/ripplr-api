module Follows
  class CreateService < Resources::BaseService
    def save
      success = @resource.save
      if success
        generate_notification
        Mixpanel::TrackFollowCreatedWorker.perform_async(@resource.id)
      end
      success
    end

    private

    def generate_notification
      return unless @resource.followable_type == 'User'

      Notifications::NewFollower.create(user: @resource.followable, follower: @resource.user)
    end
  end
end
