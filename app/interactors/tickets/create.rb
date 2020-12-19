module Tickets
  class Create < ApplicationInteractor
    def call
      context.fail! unless context.resource.save

      SupportMailer.new_ticket(context.resource).deliver_later
    end
  end
end
