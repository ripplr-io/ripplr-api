class WelcomeController < ApplicationController
  LIST_ID = '87154130ad'.freeze

  def status
    head :ok
  end

  def subscribe
    gibbon = Gibbon::Request.new(api_key: Rails.application.credentials[:mailchimp_token])

    gibbon.lists(LIST_ID).members.create(body: {
      email_address: params[:email],
      status: :subscribed
    })

    render json: { status: :success }, status: :ok
  end
end
