module Notifications
  class ReferralAccepted < Notification
    attr_accessor :referral

    before_validation :set_data

    private

    def set_data
      return if @referral.nil?

      self.data = {
        type: type.split('::').last.underscore,
        id: @referral.id,
        author_id: @referral.invitee_id
      }
    end
  end
end
