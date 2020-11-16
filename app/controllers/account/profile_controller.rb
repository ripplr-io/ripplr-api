module Account
  class ProfileController < ApplicationController
    include Crudable

    before_action :doorkeeper_authorize!

    def update
      current_user.assign_attributes(profile_params)
      update_resource(current_user)
    end

    private

    def profile_params
      avatar_params = { avatar: params[:avatar_file] } if params[:avatar_file].present?
      params.permit(:name, :slug, :bio).merge!(avatar_params)
    end
  end
end
