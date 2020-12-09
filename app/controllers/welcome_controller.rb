class WelcomeController < ApplicationController
  LIST_ID = '87154130ad'.freeze

  authorize_resource class: :welcome

  def status
    head :ok
  end

  def subscribe
    sg = SendGrid::API.new(api_key: Rails.application.credentials[:sendgrid_token])
    response = sg.client.marketing.contacts.put(request_body: {
      contacts: [{ email: params[:email] }]
    })

    Slack::NotifyService.new.subscriber(params[:email])

    render json: { status: :success }, status: :ok
  end
end
