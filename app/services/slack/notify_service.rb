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

    def ping(message, channel)
      @notifier.ping message, channel: channel
    end
  end
end
