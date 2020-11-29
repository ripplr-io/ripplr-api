class FollowsController < ApplicationController
  include Crudable

  load_resource :user
  load_and_authorize_resource through: :user, shallow: true

  def index
    @follows = current_user.follows if @user.blank?
    read_resource(@follows, included_associations: [:followable])
  end

  def create
    @follow = Follows::CreateService.new(@follow)
    create_resource(@follow, included_associations: [:followable])
  end

  def destroy
    destroy_resource(@follow)
  end

  private

  def follow_params
    params.permit(:followable_id).merge(
      followable_type: params[:followable_type]&.capitalize
    )
  end
end
