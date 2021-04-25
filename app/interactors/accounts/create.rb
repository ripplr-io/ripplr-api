module Accounts
  class Create < ApplicationInteractor
    def call
      context.resource.level = Level.first
      context.resource.billing ||= Billing.new
      context.resource.profile ||= Profile.new
      context.resource.channels.build(name: 'Email', channelable: Channel::Email.new)
      context.resource.inboxes.build(name: 'Main Inbox')

      context.fail! unless context.resource.save

      # FIXME: Move this to a ReferralAcceptWorker?
      if context.resource.referral.present?
        context.resource.referral.update(accepted_at: Time.current)
        Notifications::ReferralAccepted.create(user: context.resource.referral.inviter, referral: context.resource.referral)
        Prizes::ReferralAcceptedWorker.perform_async(context.resource.referral.id)
        Alerts::ReferralAcceptedWorker.perform_async(context.resource.referral.id)
        Prizes::Onboarding::FirstReferralWorker.perform_async(context.resource.referral.inviter.id)
      else
        Slack::NotifyService.new.ping("New user signed up: #{context.resource.profile.name} <#{context.resource.email}>", '#marketing')
      end

      Trackers::TrackSignupWorker.perform_async(context.resource.id)
      Sendgrid::SyncUserWorker.perform_async(context.resource.id)
    end
  end
end
