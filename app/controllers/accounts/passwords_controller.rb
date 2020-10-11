module Accounts
  class PasswordsController < Devise::PasswordsController
    wrap_parameters :user

    before_action :rename_params

    # POST /resource/password
    def create
      update
    end

    # PUT /resource/password
    # def update
    #   super
    # end

    # protected

    # def after_resetting_password_path_for(resource)
    #   super(resource)
    # end

    # The path used after sending reset password instructions
    # def after_sending_reset_password_instructions_path_for(resource_name)
    #   super(resource_name)
    # end

    private

    def rename_params
      params[:user][:reset_password_token] = params[:token]
    end
  end
end
