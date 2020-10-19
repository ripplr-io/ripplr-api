class AccountsController < ApplicationController
  include Crudable

  before_action :authenticate_user!

  def destroy
    destroy_resource(current_user) do
      SupportMailer.with(user: current_user, comment: params[:comments]).account_deleted.deliver_later
    end
  end
end
