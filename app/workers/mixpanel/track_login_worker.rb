module Mixpanel
  class TrackLoginWorker < BaseWorker
    EVENT_NAME = 'Login'.freeze

    def perform(user_id, ip, browser, platform)
      user = User.find_by(id: user_id)
      return if user.blank?

      service = Mixpanel::BaseService.new(user)

      browser_options = {
        '$browser' => browser,
        '$os' => platform
      }

      service.sync_user(ip: ip, browser_options: browser_options)
      service.track(EVENT_NAME, browser_options)
    end
  end
end
