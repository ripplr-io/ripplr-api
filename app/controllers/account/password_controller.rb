module Account
  class PasswordController < ApplicationController
    include Crudable
    include PasswordValidatable

    before_action :doorkeeper_authorize!
    before_action :validate_password!

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
