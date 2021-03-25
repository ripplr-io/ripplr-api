class WelcomeController < ApplicationController
  authorize_resource class: :welcome

  def status
    head :ok
  end

  def subscribe
    lead = LeadForm.new(email: params[:email])
    return render_errors(lead.errors) unless lead.valid?

    Sendgrid::CreateLeadWorker.perform_async(lead.email)
    head :no_content
  end
end
