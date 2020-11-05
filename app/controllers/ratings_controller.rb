class RatingsController < ApplicationController
  include Crudable

  before_action :doorkeeper_authorize!

  def create
    @rating = current_user.ratings.new(rating_params)
    create_resource(@rating)
  end

  private

  def rating_params
    params.permit(:points).merge!(
      ratable_id: params[:post_id],
      ratable_type: 'Post'
    )
  end
end
