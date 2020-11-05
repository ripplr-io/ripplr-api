class AccountController < ApplicationController
  include Crudable
  include PasswordValidatable

  before_action :doorkeeper_authorize!
  before_action :validate_password, only: :destroy

  def show
    read_resource(current_user)
  end

  def update
    current_user.assign_attributes(account_params)
    update_resource(current_user)
  end

  def destroy
    resource = Accounts::DestroyService.new(current_user, params[:comments])
    destroy_resource(resource)
  end

  private

  def account_params
    params.permit(:email, :country, :timezone)
  end
end
