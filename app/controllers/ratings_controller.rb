class RatingsController < ApplicationController
  # TODO: Make this Restful
  def create
    current_user.ratings.new(ratable_id: params[:post_id], points: params[:rate])
  end
end
