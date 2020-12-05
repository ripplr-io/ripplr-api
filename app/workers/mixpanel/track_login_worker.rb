module Mixpanel
  class TrackLoginWorker < BaseWorker
    EVENT_NAME = 'Login'.freeze

    def perform(user_id, ip, browser, platform)
      service = Mixpanel::BaseService.new(user_id)

      browser_options = {
        '$browser' => browser,
        '$os' => platform
      }

      service.sync_user(ip: ip, browser_options: browser_options)
      service.track(EVENT_NAME, browser_options)
    end
  end
end
