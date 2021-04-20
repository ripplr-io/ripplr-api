module Subscriptions
  class Create < ApplicationInteractor
    def call
      context.fail! unless context.resource.save

      Trackers::TrackSubscriptionCreatedWorker.perform_async(context.resource.id)
      Prizes::Onboarding::FirstSubscriptionWorker.perform_async(context.resource.user.id)
    end
  end
end
