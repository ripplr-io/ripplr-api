module Alerts
  class ReferralAcceptedWorker < BaseWorker
    def perform(referral_id)
      referral = Referral.find_by(id: referral_id)
      return if referral.blank? || referral.invitee.blank?

      message = "#{referral.invitee.profile.name} accepted #{referral.inviter.profile.name}'s invite."
      Slack::NotifyService.new.ping(message, '#marketing')
    end
  end
end
