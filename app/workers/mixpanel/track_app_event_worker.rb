module Mixpanel
  class TrackAppEventWorker < BaseWorker
    def perform(user_id, event_name, data = {})
      user = User.find_by(id: user_id)
      return if user.blank?

      Mixpanel::BaseService.new(user).track(event_name, data)
    end
  end
end
