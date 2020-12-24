module Stripe
  class CheckoutSessionsController < ApplicationController
    authorize_resource class: :stripe

    def create
      create_stripe_customer if current_user.billing.stripe_customer_id.blank?

      render json: { sessionId: session.id }
    rescue Stripe::APIError => e
      Rails.logger.error "Checkout Session failed with error: #{e}"
      Raven.capture_exception e

      render json: { error: e }, status: :bad_request
    end

    private

    def session
      Stripe::Checkout::Session.create(
        success_url: app_checkout_session_success_url,
        cancel_url: app_checkout_session_cancel_url,
        payment_method_types: ['card'],
        mode: 'subscription',
        customer: current_user.billing.stripe_customer_id,
        line_items: [{
          quantity: 1,
          price: params[:priceId]
        }]
      )
    end

    def create_stripe_customer
      customer = Stripe::Customer.create({
        email: current_user.email,
        name: current_user.name,
        metadata: { user_id: current_user.id }
      })

      current_user.billing.update!(stripe_customer_id: customer.id)
    end
  end
end
