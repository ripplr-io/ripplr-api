module Sendgrid
  class CreateLeadWorker < ApplicationWorker
    def perform(email)
      Sendgrid::SubscriptionService.new.create_lead(email)
      Alerts::NewLeadWorker.perform_async(email)
    end
  end
end
