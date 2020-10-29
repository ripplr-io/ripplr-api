module Follows
  class CreateService < Resources::CreateService
    def initialize(attributes)
      super(Follow.new(attributes))
    end

    def save
      success = @resource.save
      generate_notification if success
      success
    end

    private

    def generate_notification
      return unless @resource.followable_type == 'User'

      Notifications::NewFollower.create(user: @resource.followable, follower: @resource.user)
    end
  end
end
