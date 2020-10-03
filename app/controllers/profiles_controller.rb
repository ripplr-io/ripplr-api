class ProfilesController < ApplicationController
  wrap_parameters User

  def update
    current_user.update!(profile_params)
  end

  private

  def profile_params
    params.require(:user).permit(:name, :slug, :bio, :avatar)
  end
end
