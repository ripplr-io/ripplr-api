module Subscriptions
  class Create < ApplicationInteractor
    before :check_limit_reached

    def call
      context.fail! unless context.resource.save

      Mixpanel::TrackSubscriptionCreatedWorker.perform_async(context.resource.id)
      Prizes::Onboarding::FirstSubscriptionWorker.perform_async(context.resource.user.id)
    end

    private

    def check_limit_reached
      return unless above_level_limit?

      context.resource.errors.add(:max_subscriptions, 'limit reached')
      context.fail!
    end

    def above_level_limit?
      context.resource.user.subscriptions.count >= context.resource.user.level.subscriptions
    end
  end
end
