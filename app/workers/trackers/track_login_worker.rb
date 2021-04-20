module Trackers
  class TrackLoginWorker < BaseWorker
    EVENT_NAME = 'Login'.freeze

    def perform(user_id)
      user = User.find_by(id: user_id)
      return if user.blank?

      Analytics.identify(user)
      Analytics.track(user, EVENT_NAME)
    end
  end
end
