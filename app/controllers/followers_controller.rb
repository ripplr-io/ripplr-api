class FollowersController < ApplicationController
  include Crudable

  load_and_authorize_resource class: :follower

  # TODO: Use cancancan
  def index
    user = User.friendly.find(params[:user_id])
    read_resource(user.followers)
  end
end
