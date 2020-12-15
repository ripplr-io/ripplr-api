class AccountController < ApplicationController
  include Crudable
  include PasswordValidatable

  authorize_resource class: :account
  before_action :validate_password!, only: :destroy

  def show
    read_resource(current_user, serializer: AccountSerializer, included_associations: [:level])
  end

  def update
    current_user.assign_attributes(account_params)
    update_resource(current_user, serializer: AccountSerializer, included_associations: [:level])
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
