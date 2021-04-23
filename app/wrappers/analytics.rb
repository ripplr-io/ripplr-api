class Analytics
  class << self
    def identify(user)
      client.identify(
        user_id: user.id,
        traits: {
          email: user.email,
          name: user.profile.name,
          createdAt: user.created_at
        }
      )
    end

    def track(user, event_name, properties = {})
      client.track(
        user_id: user.id,
        event: event_name,
        properties: properties
      )
    end

    private

    def client
      Segment::Analytics.new(write_key: Rails.application.credentials[:segment_key])
    end
  end
end
