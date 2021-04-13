module Segment
  class TrackLoginWorker < BaseWorker
    EVENT_NAME = 'Login'.freeze

    def perform(user_id)
      user = User.find_by(id: user_id)
      return if user.blank?

      Segment::IdentifyService.new.call(user)
      Segment::TrackService.new.call(user, EVENT_NAME)
    end
  end
end
