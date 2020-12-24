module Stripe
  class CustomerPortalsController < ApplicationController
    authorize_resource class: :stripe

    def create
      session = Stripe::BillingPortal::Session.create({
        customer: current_user.billing.stripe_customer_id,
        return_url: app_customer_portal_return_url
      })

      render json: { url: session.url }
    rescue Stripe::APIError => e
      Rails.logger.error "Customer Portal failed with error: #{e}"
      Raven.capture_exception e

      render json: { error: e }, status: :bad_request
    end
  end
end
