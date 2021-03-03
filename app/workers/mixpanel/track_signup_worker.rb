module Mixpanel
  class TrackSignupWorker < BaseWorker
    EVENT_NAME = 'Signup'.freeze

    def perform(user_id)
      user = User.find_by(id: user_id)
      return if user.blank?

      service = Mixpanel::BaseService.new(user)
      service.sync_user(ip: 0)
      service.track(EVENT_NAME)
    end
  end
end
