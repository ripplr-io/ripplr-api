module Account
  class ProfileController < ApplicationController
    include JsonApi::Crudable

    authorize_resource class: :account

    serializer class: AccountSerializer, include: [:level]

    def update
      current_user.assign_attributes(profile_params)
      update_resource(current_user)
    end

    private

    def profile_params
      avatar_params = { avatar: params[:avatar_file] } if params[:avatar_file].present?
      params.permit(:name, :slug, :bio).merge(avatar_params)
    end
  end
end
