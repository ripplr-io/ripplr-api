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

      default_properties = {
        '$name' => @user.name,
        '$email' => @user.email,
        '$created' => @user.created_at
      }.merge(browser_options)

      custom_properties = {
        'Medium' => @user.acquisition.medium,
        'Source' => @user.acquisition.source,
        'Campaign' => @user.acquisition.campaign
      }

      properties = default_properties.merge(custom_properties)
      @tracker.people.set(@user.id, properties, ip)
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
