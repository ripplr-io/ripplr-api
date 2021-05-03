module Account
  class PasswordController < ApplicationController
    include JsonApi::Crudable
    include PasswordValidatable

    authorize_resource class: :account
    before_action :validate_password!

    serializer class: AccountSerializer, include: [:profile, :level]

    def update
      current_user.assign_attributes(password_params)
      update_resource(current_user)
    end

    private

    def password_params
      {
        password: params[:new_password],
        password_confirmation: params[:new_password_confirmation]
      }
    end
  end
end
