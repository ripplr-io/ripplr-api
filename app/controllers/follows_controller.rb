class FollowsController < ApplicationController
  include Crudable

  before_action :doorkeeper_authorize!

  def index
    read_resource(current_user.follows)
  end

  def create
    @follow = Follows::CreateService.new(follow_params.merge!(user: current_user))
    create_resource(@follow)
  end

  def destroy
    @follow = current_user.follows.find(params[:id])
    destroy_resource(@follow)
  end

  private

  def follow_params
    params.permit(:followable_id).merge!(
      followable_type: params[:followable_type]&.capitalize
    )
  end
end
