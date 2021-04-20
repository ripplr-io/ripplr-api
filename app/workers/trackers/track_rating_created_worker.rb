module Trackers
  class TrackRatingCreatedWorker < BaseWorker
    EVENT_NAME = 'Rating Created'.freeze

    def perform(rating_id)
      rating = Rating.find_by(id: rating_id)
      return if rating.blank?

      Analytics.track(rating.user, EVENT_NAME)
    end
  end
end
