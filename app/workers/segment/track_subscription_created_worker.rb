module Segment
  class TrackSubscriptionCreatedWorker < BaseWorker
    EVENT_NAME = 'Subscription Created'.freeze

    def perform(subscription_id)
      subscription = Subscription.find_by(id: subscription_id)
      return if subscription.blank?

      Segment::TrackService.new.call(subscription.user, EVENT_NAME)
    end
  end
end
