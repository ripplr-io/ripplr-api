module Tickets
  class CreateService < Resources::CreateService
    def initialize(attributes)
      super(Ticket.new(attributes))
    end

    def save
      success = @resource.save
      SupportMailer.new_ticket(@resource).deliver_later if success
      success
    end
  end
end
