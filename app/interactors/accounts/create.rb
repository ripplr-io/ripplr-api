module Accounts
  class Create < ApplicationInteractor
    def call
      context.resource.level = Level.first
      context.resource.build_billing
      context.resource.bookmark_folders.build(name: 'Root')
      context.resource.channels.build(name: 'Email', channelable: Channel::Email.new)
      context.resource.inboxes.build(name: 'Main Inbox')
      context.resource.referral = Referral.find_by(id: context.referral_id)

      context.fail! unless context.resource.save

      # FIXME: Move this to a ReferralAcceptWorker?
      if context.resource.referral.present?
        context.resource.referral.touch(:accepted_at)
        Notifications::ReferralAccepted.create(user: context.resource.referral.inviter, referral: context.resource.referral)
        Prizes::ReferralAcceptedWorker.perform_async(context.resource.referral.id)
        Alerts::ReferralAcceptedWorker.perform_async(context.resource.referral.id)
        Prizes::Onboarding::FirstReferralWorker.perform_async(context.resource.referral.inviter.id)
      else
        Slack::NotifyService.new.ping("New user signed up: #{context.resource.name} <#{context.resource.email}>", '#marketing')
      end

      Mixpanel::TrackSignupWorker.perform_async(context.resource.id)
      Sendgrid::SyncUserWorker.perform_async(context.resource.id)
    end
  end
end
