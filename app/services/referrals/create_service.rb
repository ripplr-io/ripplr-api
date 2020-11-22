module Referrals
  class CreateService < Resources::CreateService
    def initialize(attributes)
      super(Referral.new(attributes))
    end

    def save
      if above_level_limit?
        @resource.errors.add(:max_referrals, 'limit reached')
        return false
      end

      success = @resource.save
      if success
        ReferralMailer.with(referral: @resource).invite.deliver_later
        Prizes::ReferralCreatedWorker.perform_async(@resource.id)
        Mixpanel::TrackReferralCreatedWorker.perform_async(@resource.id)
      end
      success
    end

    private

    def above_level_limit?
      @resource.inviter.referrals.count >= @resource.inviter.level.referrals
    end
  end
end
