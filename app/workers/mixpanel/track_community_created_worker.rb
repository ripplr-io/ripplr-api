module Mixpanel
  class TrackCommunityCreatedWorker < BaseWorker
    EVENT_NAME = 'Community Created'.freeze

    def perform(community_id)
      community = Community.find_by(id: community_id)
      return if community.blank?

      Mixpanel::BaseService.new(community.owner).track(EVENT_NAME)
    end
  end
end
