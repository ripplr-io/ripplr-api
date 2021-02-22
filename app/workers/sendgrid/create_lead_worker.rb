module Sendgrid
  class CreateLeadWorker < ApplicationWorker
    def perform(email)
      Sendgrid::ContactService.new.create_lead(email)
      Alerts::NewLeadWorker.perform_async(email)
    end
  end
end
