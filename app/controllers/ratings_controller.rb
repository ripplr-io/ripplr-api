class RatingsController < ApplicationController
  include Crudable

  before_action :doorkeeper_authorize!

  def create
    post = Post.find_by(id: params[:post_id])
    @rating = Ratings::CreateService.new(current_user, post, params[:rate])
    create_resource(@rating)
  end
end
