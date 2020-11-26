class FollowsController < ApplicationController
  include Crudable

  before_action :doorkeeper_authorize!

  def index
    user = User.find_by(id: params[:user_id]) || current_user
    read_resource(user.follows, included_associations: [:followable])
  end

  def create
    @follow = Follows::CreateService.new(follow_params.merge(user: current_user))
    create_resource(@follow, included_associations: [:followable])
  end

  def destroy
    @follow = current_user.follows.find(params[:id])
    destroy_resource(@follow)
  end

  private

  def follow_params
    params.permit(:followable_id).merge(
      followable_type: params[:followable_type]&.capitalize
    )
  end
end
