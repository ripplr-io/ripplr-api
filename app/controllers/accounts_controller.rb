class AccountsController < ApplicationController
  include Crudable

  before_action :authenticate_user!

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

  def account_params
    params.permit(:email, :country, :timezone)
  end
end
