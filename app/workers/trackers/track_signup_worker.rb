module Trackers
  class TrackSignupWorker < BaseWorker
    EVENT_NAME = 'Signup'.freeze

    def perform(user_id)
      user = User.find_by(id: user_id)
      return if user.blank?

      Analytics.identify(user)
      Analytics.track(user, EVENT_NAME)
    end
  end
end
