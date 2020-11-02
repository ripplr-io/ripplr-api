module Notifications
  class ReferralAccepted < Notification
    attr_accessor :referral

    before_validation :set_data

    after_commit :broadcast, on: :create

    private

    def set_data
      return if @referral.nil?

      self.data = {
        # FIXME: replace these in the frontend instead
        type: type.split('::').last.underscore,
        id: @referral.id,
        author: @referral.invitee.as_json,
        user_id: user_id
      }
    end
  end
end
