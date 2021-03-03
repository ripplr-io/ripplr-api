module Mixpanel
  class TrackReferralCreatedWorker < BaseWorker
    EVENT_NAME = 'Referral Created'.freeze

    def perform(referral_id)
      referral = Referral.find_by(id: referral_id)
      return if referral.blank?

      Mixpanel::BaseService.new(referral.inviter).track(EVENT_NAME)
    end
  end
end
