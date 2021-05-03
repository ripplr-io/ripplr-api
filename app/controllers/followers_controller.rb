class FollowersController < ApplicationController
  include JsonApi::Crudable

  before_action :rename_params

  load_resource :profile
  load_and_authorize_resource :profile, parent: false, through: :profile, through_association: :follower_profiles

  def index
    read_resource(@profiles)
  end

  private

  # FIXME: This can be removed once the names change in the frontend
  def rename_params
    params[:profile_id] = params[:user_id]
  end
end
