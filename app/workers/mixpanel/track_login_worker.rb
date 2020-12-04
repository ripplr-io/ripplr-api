module Mixpanel
  class TrackLoginWorker < BaseWorker
    EVENT_NAME = 'Login'.freeze

    def perform(user_id)
      service = Mixpanel::BaseService.new(user_id)
      service.sync_user
      service.track(EVENT_NAME)
    end
  end
end
