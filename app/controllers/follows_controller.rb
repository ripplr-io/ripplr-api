class FollowsController < ApplicationController
  include JsonApi::Crudable

  before_action :rename_params

  load_resource :profile
  load_and_authorize_resource through: [:profile, :current_user], shallow: true

  serializer include: [:followable]

  def index
    @follows = @follows
      .includes(:followable)

    read_resource(@follows)
  end

  def create
    create_resource(@follow, interactor: Follows::Create)
  end

  def destroy
    destroy_resource(@follow)
  end

  private

  # FIXME: This can be removed once the names change in the frontend
  def rename_params
    params[:profile_id] = params[:user_id]
  end

  def follow_params
    params.permit(:followable_id).merge(
      followable_type: params[:followable_type]&.capitalize
    )
  end
end
