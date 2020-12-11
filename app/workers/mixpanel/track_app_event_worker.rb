module Mixpanel
  class TrackAppEventWorker < BaseWorker
    def perform(user_id, event_name, data = {})
      Mixpanel::BaseService.new(user_id).track(event_name, data)
    end
  end
end
