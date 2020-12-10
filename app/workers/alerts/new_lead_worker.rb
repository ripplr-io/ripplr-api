module Alerts
  class NewLeadWorker < BaseWorker
    def perform(email)
      Slack::NotifyService.new.ping("New subscriber: #{email}.", '#marketing')
    end
  end
end
