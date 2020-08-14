class RatingsController < ApplicationController
  # TODO: Make this Restful
  def create
    current_user.ratings.create!(ratable: Post.find(params[:post_id]), points: params[:rate])
  end
end
