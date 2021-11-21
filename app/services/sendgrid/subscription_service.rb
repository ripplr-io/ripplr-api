module Sendgrid
  class SubscriptionService < BaseService
    MARKETING_GROUP_ID = '14453'.freeze

    def sync_user(user)
      return if user.profile.bot?

      user.subscribed_to_marketing ? subscribe(user.email) : unsubscribe(user.email)
    end

    private

    def unsubscribe(email)
      @sg.client.asm.groups._(MARKETING_GROUP_ID).suppressions.post(request_body: {
        recipient_emails: [email]
      })
    end

    def subscribe(email)
      @sg.client.asm.groups._(MARKETING_GROUP_ID).suppressions._(email).delete
    end
  end
end
