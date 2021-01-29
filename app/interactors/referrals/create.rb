module Referrals
  class Create < ApplicationInteractor
    before :check_limit_reached

    def call
      context.fail! unless context.resource.save

      Referrals::InviteMailer.perform_async(context.resource.id)
      Prizes::ReferralCreatedWorker.perform_async(context.resource.id)
      Mixpanel::TrackReferralCreatedWorker.perform_async(context.resource.id)
      Alerts::ReferralCreatedWorker.perform_async(context.resource.id)
    end

    private

    def check_limit_reached
      return unless above_level_limit?

      context.resource.errors.add(:max_referrals, 'limit reached')
      context.fail!
    end

    def above_level_limit?
      context.resource.inviter.referrals.count >= context.resource.inviter.level.referrals
    end
  end
end
