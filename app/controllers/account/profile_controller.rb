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
      params.permit(:name, :slug, :bio, :avatar)
    end
  end
end
