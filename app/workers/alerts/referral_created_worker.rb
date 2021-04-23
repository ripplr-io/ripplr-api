module Alerts
  class ReferralCreatedWorker < BaseWorker
    def perform(referral_id)
      referral = Referral.find_by(id: referral_id)
      return if referral.blank?

      message = "#{referral.inviter.profile.name} invited #{referral.email} (#{referral.name})."
      Slack::NotifyService.new.ping(message, '#marketing')
    end
  end
end
