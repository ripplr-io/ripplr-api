module Segment
  class TrackService < BaseService
    def call(user, event_name, properties = {})
      @analytics.track(
        user_id: user.id,
        event: event_name,
        properties: properties
      )
    end
  end
end
