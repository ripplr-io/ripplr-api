module Segment
  class TrackCommunityCreatedWorker < BaseWorker
    EVENT_NAME = 'Community Created'.freeze

    def perform(community_id)
      community = Community.find_by(id: community_id)
      return if community.blank?

      Segment::TrackService.new.call(community.owner, EVENT_NAME)
    end
  end
end
