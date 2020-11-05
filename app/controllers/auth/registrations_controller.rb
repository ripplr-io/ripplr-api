module Auth
  class RegistrationsController < Devise::RegistrationsController
    include Crudable

    respond_to :json
    wrap_parameters :user

    before_action :configure_sign_up_params, only: [:create]
    # before_action :configure_account_update_params, only: [:update]

    # POST /resource
    def create
      user = Accounts::CreateService.new(sign_up_params, referral_id: params[:referral_id])
      return render_errors(user) unless user.save

      token = user.resource.access_tokens.create!(
        use_refresh_token: true,
        expires_in: Doorkeeper.configuration.access_token_expires_in
      )
      render json: Doorkeeper::OAuth::TokenResponse.new(token).body, status: :created
    end

    # PUT /resource
    # def update
    #   super
    # end

    # DELETE /resource
    # def destroy
    #   super
    # end

    # GET /resource/cancel
    # Forces the session data which is usually expired after sign
    # in to be expired now. This is useful if the user wants to
    # cancel oauth signing in/up in the middle of the process,
    # removing all OAuth session data.
    # def cancel
    #   super
    # end

    protected

    # If you have extra params to permit, append them to the sanitizer.
    def configure_sign_up_params
      devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    end

    # If you have extra params to permit, append them to the sanitizer.
    # def configure_account_update_params
    #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
    # end

    # The path used after sign up.
    # def after_sign_up_path_for(resource)
    #   super(resource)
    # end

    # The path used after sign up for inactive accounts.
    # def after_inactive_sign_up_path_for(resource)
    #   super(resource)
    # end
  end
end
