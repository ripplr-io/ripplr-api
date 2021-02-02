module Tickets
  class Create < ApplicationInteractor
    def call
      context.fail! unless context.resource.save

      Support::NewTicketMailer.perform_async(context.resource.id)
    end
  end
end
