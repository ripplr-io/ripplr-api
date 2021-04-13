module Segment
  class IdentifyService < BaseService
    def call(user)
      @analytics.identify(
        user_id: user.id,
        traits: {
          email: user.email,
          name: user.name,
          createdAt: user.created_at
        }
      )
    end
  end
end
