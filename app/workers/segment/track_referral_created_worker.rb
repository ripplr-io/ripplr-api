module Segment
  class TrackReferralCreatedWorker < BaseWorker
    EVENT_NAME = 'Referral Created'.freeze

    def perform(referral_id)
      referral = Referral.find_by(id: referral_id)
      return if referral.blank?

      Segment::TrackService.new.call(referral.inviter, EVENT_NAME)
    end
  end
end
