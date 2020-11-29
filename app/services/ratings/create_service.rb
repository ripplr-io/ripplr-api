module Ratings
  class CreateService < Resources::BaseService
    def initialize(resource)
      rating = Rating.find_by(user: resource.user, ratable: resource.ratable)
      rating = resource if rating.blank?
      rating.points = resource.points
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
