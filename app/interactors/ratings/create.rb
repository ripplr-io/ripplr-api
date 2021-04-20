module Ratings
  class Create < ApplicationInteractor
    before :find_or_build_resource

    def call
      context.fail! unless context.resource.save

      Users::UpdateLevelWorker.perform_async(context.resource.ratable.author.id)
      Posts::UpdateTrendingScoreWorker.perform_async(context.resource.ratable.id)
      Trackers::TrackRatingCreatedWorker.perform_async(context.resource.id)
      Prizes::Onboarding::FirstRatingWorker.perform_async(context.resource.user.id)
    end

    private

    def find_or_build_resource
      rating = Rating.find_by(user: context.resource.user, ratable: context.resource.ratable)
      rating = context.resource if rating.blank?
      rating.points = context.resource.points
      context.resource = rating
    end
  end
end
