module Notifications
  class ReferralAccepted < Notification
    attr_accessor :referral

    before_validation :set_data

    after_commit :broadcast, on: :create

    private

    def set_data
      return if @referral.nil?

      self.data = {
        # TODO: replace these in the frontend
        type: type.split('::').last.underscore,
        id: @referral.id,
        # author: @referral.invitee.as_json # TODO: serialize this
        user_id: user_id
      }
    end
  end
end
