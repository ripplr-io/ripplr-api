module Prizes
  class ReferralCreatedWorker < ApplicationWorker
    PRIZE_NAME = 'Referral Created'.freeze

    def perform(referral_id)
      referral = Referral.find_by(id: referral_id)
      return if referral.blank?
      return if referral.prizes.find_by(name: PRIZE_NAME).present?

      Prizes::CreateService.new({
        user: referral.inviter,
        prizable: referral,
        name: PRIZE_NAME,
        points: 10
      }).save
    end
  end
end
