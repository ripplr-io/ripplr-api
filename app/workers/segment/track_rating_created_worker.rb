module Segment
  class TrackRatingCreatedWorker < BaseWorker
    EVENT_NAME = 'Rating Created'.freeze

    def perform(rating_id)
      rating = Rating.find_by(id: rating_id)
      return if rating.blank?

      Segment::TrackService.new.call(rating.user, EVENT_NAME)
    end
  end
end
