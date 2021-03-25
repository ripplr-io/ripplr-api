class FollowsController < ApplicationController
  include JsonApi::Crudable

  load_resource :user
  load_and_authorize_resource through: [:user, :current_user], shallow: true

  serializer include: [:followable]

  def index
    read_resource(@follows)
  end

  def create
    create_resource(@follow, interactor: Follows::Create)
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
