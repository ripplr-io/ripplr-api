module Mixpanel
  class BaseService
    def initialize(user_id)
      @user_id = user_id
      @tracker = Mixpanel::Tracker.new(Rails.application.credentials[:mixpanel_token]) do |type, message|
        eu_consumer.send!(type, message)
      end
    end

    def track(event, options = {})
      @tracker.track(@user_id, event, options)
    end

    # TODO: pass the original ip to get geo info for the user
    def sync_user
      user = User.find_by(id: @user_id)
      return if user.blank?

      @tracker.people.set(@user_id, {
        '$name' => user.name,
        '$email' => user.email,
        '$created' => user.created_at
      }, 0, {
        '$ignore_time' => 'true'
      })
    end

    private

    def eu_consumer
      Mixpanel::Consumer.new(
        'https://api-eu.mixpanel.com/track',
        'https://api-eu.mixpanel.com/engage',
        'https://api-eu.mixpanel.com/groups'
      )
    end
  end
end
