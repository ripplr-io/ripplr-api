class FollowersController < ApplicationController
  include Crudable

  before_action :doorkeeper_authorize!

  def index
    user = User.friendly.find(params[:user_id])
    read_resource(user.followers)
  end
end
