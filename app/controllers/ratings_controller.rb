class RatingsController < ApplicationController
  include Crudable

  authorize_resource

  # TODO: Use cancancan
  def create
    post = Post.find_by(id: params[:post_id])
    @rating = Ratings::CreateService.new(current_user, post, params[:rate])
    create_resource(@rating)
  end
end
