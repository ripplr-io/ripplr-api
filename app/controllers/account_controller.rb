class AccountController < ApplicationController
  include JsonApi::Crudable
  include PasswordValidatable

  authorize_resource class: :account
  before_action :validate_password!, only: :destroy

  serializer class: AccountSerializer, include: [:profile, :level]

  def show
    read_resource(current_user)
  end

  def update
    current_user.assign_attributes(account_params)
    update_resource(current_user)
  end

  def destroy
    destroy_resource(current_user, interactor: Accounts::Destroy, context: destroy_context)
  end

  private

  def account_params
    params.permit(:email, :country, :timezone)
  end

  def destroy_context
    { comment: params[:comments] }
  end
end
