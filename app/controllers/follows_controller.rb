class FollowsController < ApplicationController
  include JsonApi::Crudable

  load_resource :user
  load_and_authorize_resource through: :user, shallow: true

  serializer include: [:followable]

  def index
    @follows = current_user.follows if @user.blank?
    read_resource(@follows)
  end

  def create
    @follow = Follows::CreateService.new(@follow)
    create_resource(@follow)
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
