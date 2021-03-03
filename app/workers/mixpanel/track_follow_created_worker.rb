module Mixpanel
  class TrackFollowCreatedWorker < BaseWorker
    EVENT_NAME = 'Follow Created'.freeze

    def perform(follow_id)
      follow = Follow.find_by(id: follow_id)
      return if follow.blank?

      Mixpanel::BaseService.new(follow.user).track(EVENT_NAME, {
        'Followable type' => follow.followable_type
      })
    end
  end
end
