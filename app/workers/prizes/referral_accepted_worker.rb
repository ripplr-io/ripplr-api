module Prizes
  class ReferralAcceptedWorker
    include Sidekiq::Worker

    PRIZE_NAME = 'Referral Accepted'.freeze

    def perform(referral_id)
      referral = Referral.find_by(id: referral_id)
      return if referral.blank?
      return if referral.prizes.find_by(name: PRIZE_NAME).present?

      Prizes::CreateService.new({
        user: referral.inviter,
        prizable: referral,
        name: PRIZE_NAME,
        points: 50
      }).save
    end
  end
end
