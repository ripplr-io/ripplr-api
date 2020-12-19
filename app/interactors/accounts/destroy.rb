module Accounts
  class Destroy < ApplicationInteractor
    def call
      SupportMailer.account_deleted(context.resource, context.comment).deliver_later

      context.fail! unless context.resource.destroy

      Users::AnonymizeWorker.perform_async(context.resource.id)
    end
  end
end
