module Mixpanel
  class TrackSignupWorker < BaseWorker
    EVENT_NAME = 'Signup'.freeze

    def perform(user_id)
      service = Mixpanel::BaseService.new(user_id)
      service.sync_user
      service.track(EVENT_NAME)
    end
  end
end
