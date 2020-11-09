class RatingsController < ApplicationController
  include Crudable

  before_action :doorkeeper_authorize!

  def create
    @rating = current_user.ratings.find_or_initialize_by(rating_params)
    @rating.points = params[:rate]

    create_resource(@rating)
  end

  private

  def rating_params
    {
      ratable_id: params[:post_id],
      ratable_type: 'Post'
    }
  end
end
