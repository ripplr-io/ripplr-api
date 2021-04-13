module Segment
  class TrackFollowCreatedWorker < BaseWorker
    EVENT_NAME = 'Follow Created'.freeze

    def perform(follow_id)
      follow = Follow.find_by(id: follow_id)
      return if follow.blank?

      Segment::TrackService.new.call(follow.user, EVENT_NAME, {
        'Followable type' => follow.followable_type
      })
    end
  end
end
