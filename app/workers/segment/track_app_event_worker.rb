module Segment
  class TrackAppEventWorker < BaseWorker
    def perform(user_id, event_name, data = {})
      user = User.find_by(id: user_id)
      return if user.blank?

      Segment::TrackService.new.call(user, event_name, data)
    end
  end
end
