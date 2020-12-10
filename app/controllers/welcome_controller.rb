class WelcomeController < ApplicationController
  authorize_resource class: :welcome

  def status
    head :ok
  end

  def subscribe
    Sendgrid::CreateLeadWorker.perform_async(params[:email])
    render json: { status: :success }, status: :ok
  end
end
