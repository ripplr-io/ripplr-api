module Tickets
  class CreateService < Resources::CreateService
    def initialize(attributes)
      super(Ticket.new(attributes))
    end

    def save
      success = @resource.save
      SupportMailer.with(ticket: @resource).new_ticket.deliver_later if success
      success
    end
  end
end
