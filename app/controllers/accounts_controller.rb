class AccountsController < ApplicationController
  include Crudable

  before_action :authenticate_user!, except: :refresh

  def update
    current_user.assign_attributes(account_params)
    update_resource(current_user)
  end

  # FIXME: Move to registrations#destroy
  def destroy
    resource = Accounts::DestroyService.new(current_user, params[:comments])
    destroy_resource(resource)
  end

  def onboard
    current_user.assign_attributes(onboarded_at: Time.current)
    update_resource(current_user)
  end

  def refresh
    token = request.headers['Authorization']&.split(' ')&.last
    return head :unauthorized if token.blank?

    user = Authentication::JwtDecodeService.new(token, validate_expiration: false).user
    return head :unauthorized if user.blank?

    # Invalidate older tokens
    user.update_column(:jti, SecureRandom.uuid)

    sign_in(:user, user)
    read_resource(user)
  end

  private

  def account_params
    params.permit(:email, :country, :timezone)
  end
end
