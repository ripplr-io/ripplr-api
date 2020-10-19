class FollowsController < ApplicationController
  include Crudable

  before_action :authenticate_user!

  def index
    render json: current_user.follows
  end

  def create
    @follow = current_user.follows.new(follow_params)
    create_resource(@follow)
  end

  private

  def follow_params
    params.permit(:followable_id).merge!(
      followable_type: params[:followable_type]&.capitalize
    )
  end
end
