module Accounts
  class Create < ApplicationInteractor
    def call
      context.resource.level = Level.first
      context.resource.referral = Referral.find_by(id: context.referral_id)

      ActiveRecord::Base.transaction do
        context.resource.save!
        context.resource.bookmark_folders.create!(name: 'Root')
      end

      # FIXME: Move this to a ReferralAcceptWorker?
      if context.resource.referral.present?
        context.resource.referral.touch(:accepted_at)
        Notifications::ReferralAccepted.create(user: context.resource.referral.inviter, referral: context.resource.referral)
        Prizes::ReferralAcceptedWorker.perform_async(context.resource.referral.id)
        Alerts::ReferralAcceptedWorker.perform_async(context.resource.referral.id)
        Prizes::Onboarding::FirstReferralWorker.perform_async(context.resource.referral.inviter.id)
      end

      Mixpanel::TrackSignupWorker.perform_async(context.resource.id)
      Sendgrid::SyncUserWorker.perform_async(context.resource.id)
    rescue ActiveRecord::RecordInvalid => e
      Rails.logger.error "Create Account failed with error: #{e}"
      Raven.capture_exception e
      context.fail!
    end
  end
end
