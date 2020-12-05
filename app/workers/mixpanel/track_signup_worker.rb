module Mixpanel
  class TrackSignupWorker < BaseWorker
    EVENT_NAME = 'Signup'.freeze

    def perform(user_id)
      service = Mixpanel::BaseService.new(user_id)
      service.sync_user(ip: 0)
      service.track(EVENT_NAME)
    end
  end
end
