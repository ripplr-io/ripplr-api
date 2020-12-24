module Stripe
  class PlansController < ApplicationController
    authorize_resource class: :stripe

    def index
      render json: Stripe::Plan.list({ limit: 3 })
    rescue Stripe::APIError => e
      Rails.logger.error "Plans list failed with error: #{e}"
      Raven.capture_exception e

      render json: { error: e }, status: :bad_request
    end
  end
end
