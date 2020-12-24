module Billings
  class UpdateWorker < ApplicationWorker
    def perform(customer_id, product_id, status, end_at)
      billing = Billing.find_by(stripe_customer_id: customer_id)
      return if billing.blank?

      billing.update!(
        product: product_name(product_id),
        status: status,
        end_at: Time.zone.at(end_at)
      )
    end

    private

    def product_name(product_id)
      Stripe::Product.retrieve(product_id).metadata.database_name
    end
  end
end
