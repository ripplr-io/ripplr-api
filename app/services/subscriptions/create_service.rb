module Subscriptions
  class CreateService < Resources::BaseService
    def save
      if above_level_limit?
        @resource.errors.add(:max_subscriptions, 'limit reached')
        return false
      end

      success = @resource.save
      if success
        Mixpanel::TrackSubscriptionCreatedWorker.perform_async(@resource.id)
        Prizes::Onboarding::FirstSubscriptionWorker.perform_async(@resource.user.id)
      end
      success
    end

    private

    def above_level_limit?
      @resource.user.subscriptions.count >= @resource.user.level.subscriptions
    end
  end
end
