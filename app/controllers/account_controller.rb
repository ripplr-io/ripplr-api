class AccountController < ApplicationController
  include JsonApi::Crudable
  include PasswordValidatable

  authorize_resource class: :account
  before_action :validate_password!, only: :destroy

  serializer class: AccountSerializer, include: [:level]

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
