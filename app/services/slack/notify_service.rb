module Slack
  class NoOpHTTPClient
    def self.ping(uri, params = {}); end
    def self.post(uri, params = {}); end
  end

  class NotifyService
    def initialize
      @notifier = Slack::Notifier.new(Rails.application.credentials[:slack_webhook_url]) do
        http_client NoOpHTTPClient unless Rails.env.production?
      end
    end

    def subscriber(email)
      @notifier.ping "New subscriber: #{email}.", channel: '#marketing'
    end

    def referral_created(referral)
      message = "#{referral.inviter.name} invited #{referral.email} (#{referral.name})."
      @notifier.ping message, channel: '#marketing'
    end

    def referral_accepted(referral)
      message = "#{referral.invitee.name} accepted #{referral.inviter.name} invite."
      @notifier.ping message, channel: '#marketing'
    end
  end
end
