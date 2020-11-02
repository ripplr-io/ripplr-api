module Referrals
  class CreateService < Resources::CreateService
    def initialize(attributes)
      super(Referral.new(attributes))
    end

    def save
      success = @resource.save
      ReferralMailer.with(referral: @resource).invite.deliver_later if success
      success
    end
  end
end
