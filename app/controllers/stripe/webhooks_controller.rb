module Stripe
  class WebhooksController < ApplicationController
    authorize_resource class: :webhook

    # TODO: sign the event
    def create
      payload = JSON.parse(request.body.read, symbolize_names: true)
      event = Stripe::Event.construct_from(payload)

      handle_stripe_event(event)

      head :ok
    end

    private

    def handle_stripe_event(event)
      event_object = event.data.object
      event_type = event.type

      case event_type
      when 'customer.subscription.created', 'customer.subscription.updated', 'customer.subscription.deleted'
        Billings::UpdateWorker.perform_async(
          event_object.customer,
          event_object.items.data[0].price.product,
          event_object.status,
          event_object.current_period_end
        )
      when 'invoice.paid', 'invoice.payment_failed'
        Alerts::InvoicePaymentWorker.perform_async(
          event_object.customer,
          event_object.paid,
          event_object.payment_intent
        )
      end
    end
  end
end
