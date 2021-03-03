module Mixpanel
  class BaseService
    def initialize(user)
      @user = user
      @tracker = Mixpanel::Tracker.new(Rails.application.credentials[:mixpanel_token]) do |type, message|
        next if user.bot?

        eu_consumer.send!(type, message)
      end
    end

    def track(event, options = {})
      return if @user.blank?

      @tracker.track(@user.id, event, options)
    end

    def sync_user(ip: 0, browser_options: {})
      return if @user.blank?

      @tracker.people.set(@user.id, {
        '$name' => @user.name,
        '$email' => @user.email,
        '$created' => @user.created_at
      }.merge(browser_options), ip)
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
