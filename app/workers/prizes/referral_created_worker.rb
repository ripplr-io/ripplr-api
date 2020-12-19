module Prizes
  class ReferralCreatedWorker < ApplicationWorker
    TEMPLATE = Prize::REFERRAL_PRIZES[:created]

    def perform(referral_id)
      referral = Referral.find_by(id: referral_id)
      return if referral.blank?

      prize = Prize.new({ user: referral.inviter, prizable: referral }.merge(TEMPLATE))
      return if referral.prizes.find_by(name: prize.name).present?

      Prizes::Create.call(resource: prize).call
    end
  end
end
