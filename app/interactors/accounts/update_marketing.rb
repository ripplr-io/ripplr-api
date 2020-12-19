module Accounts
  class UpdateMarketing < ApplicationInteractor
    def call
      context.fail! unless context.resource.save

      Sendgrid::SyncUserWorker.perform_async(context.resource.id)
    end
  end
end
