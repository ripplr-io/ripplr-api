module Auth
  class RegistrationsController < Devise::RegistrationsController
    alias create_params sign_up_params

    wrap_parameters :user
    before_action :configure_sign_up_params
    load_and_authorize_resource :user, parent: false

    def create
      @user.referral = Referral.find_by(id: params[:referral_id])

      result = Accounts::Create.call(resource: @user)
      return render_errors(result.resource.errors) unless result.success?

      token = result.resource.access_tokens.create!(
        use_refresh_token: true,
        expires_in: Doorkeeper.configuration.access_token_expires_in
      )
      render json: Doorkeeper::OAuth::TokenResponse.new(token).body, status: :created
    end

    protected

    def configure_sign_up_params
      devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :subscribed_to_marketing])
    end
  end
end
