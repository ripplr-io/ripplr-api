class AccountsController < ApplicationController
  include Crudable

  before_action :authenticate_user!

  # TODO: Move to registrations#destroy?
  def destroy
    resource = Accounts::DestroyService.new(current_user, params[:comments])
    destroy_resource(resource)
  end
end
