module Account
  class ProfileController < ApplicationController
    include JsonApi::Crudable

    before_action :rename_params

    authorize_resource class: :account

    serializer class: AccountSerializer, include: [:level]

    def update
      current_user.assign_attributes(profile_params)
      update_resource(current_user)
    end

    private

    # FIXME: Remove after this has been renamed in the frontend
    def rename_params
      params.delete(:avatar)
      params[:avatar] = params.delete(:avatar_file) if params[:avatar_file].present?
      params[:profile_attributes] = params.slice(:name, :slug, :bio, :avatar)
    end

    def profile_params
      params.permit(profile_attributes: [:name, :slug, :bio, :avatar])
    end
  end
end
