module Tickets
  class CreateService < Resources::BaseService
    def save
      success = @resource.save
      SupportMailer.new_ticket(@resource).deliver_later if success
      success
    end
  end
end
