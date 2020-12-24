module Alerts
  class InvoicePaymentWorker < BaseWorker
    PAYMENT_INTENTS_URL = 'https://dashboard.stripe.com/test/payments/'.freeze

    def perform(customer_id, paid, intent_id)
      billing = Billing.find_by(stripe_customer_id: customer_id)
      user_name = billing&.user&.name || 'unknown user'

      message = build_message(user_name, paid, intent_id)

      Slack::NotifyService.new.ping(message, '#stripe')
    end

    private

    def build_message(user_name, paid, intent_id)
      prefix = paid ? 'New payment' : 'Payment failed'
      prefix + " from #{user_name}:\n#{PAYMENT_INTENTS_URL + intent_id}"
    end
  end
end
