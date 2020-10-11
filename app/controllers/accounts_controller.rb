class AccountsController < ApplicationController
  def destroy
    # TODO: verify password again
    # TODO: improve responses
    if current_user.destroy!
      SupportMailer.with(user: current_user, comment: params[:comments]).account_deleted.deliver_later
      render json: { status: 200 }
    else
      render json: { status: 400 }
    end
  end
end
