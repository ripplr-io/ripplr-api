module Subscriptions
  class CreateService < Resources::CreateService
    def initialize(attributes)
      super(Subscription.new(attributes))
    end

    def save
      if above_level_limit?
        @resource.errors.add(:max_subscriptions, 'limit reached')
        return false
      end

      success = @resource.save
      Mixpanel::TrackSubscriptionCreatedWorker.perform_async(@resource.id) if success
      success
    end

    private

    def above_level_limit?
      @resource.user.subscriptions.count >= @resource.user.level.subscriptions
    end
  end
end
