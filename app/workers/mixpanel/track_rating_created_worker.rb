module Mixpanel
  class TrackRatingCreatedWorker < BaseWorker
    EVENT_NAME = 'Rating Created'.freeze

    def perform(rating_id)
      rating = Rating.find_by(id: rating_id)
      return if rating.blank?

      Mixpanel::BaseService.new(rating.user.id).track(EVENT_NAME)
    end
  end
end
