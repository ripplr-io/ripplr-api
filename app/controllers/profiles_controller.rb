class ProfilesController < ApplicationController
  include Crudable

  before_action :authenticate_user!

  def show
    read_resource(current_user)
  end

  def update
    current_user.assign_attributes(profile_params)
    update_resource(current_user)
  end

  private

  def profile_params
    params.permit(:name, :slug, :bio, :avatar)
  end
end
