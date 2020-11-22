module Ratings
  class CreateService < Resources::CreateService
    def initialize(user, ratable, points)
      rating = user.ratings.find_or_initialize_by(ratable: ratable)
      rating.points = points
      super(rating)
    end

    def save
      success = @resource.save
      if success
        Users::UpdateLevelWorker.perform_async(@resource.ratable.author.id)
        Mixpanel::TrackRatingCreatedWorker.perform_async(@resource.id)
      end
      success
    end
  end
end
