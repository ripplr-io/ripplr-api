module PushNotifications
  class SettingsService
    def initialize(post, subscription, device)
      @post = post
      @subscription = subscription
      @device = device
    end

    def topic_subscribed?
      settings = select_settings('topics')
      topics = topics_from_settings(settings)
      topics.find_by(id: @post.topic_id).present?
    end

    def next_available_slot
      settings = select_settings('availability')
      slots = slots_from_settings(settings)
      SettingsSlotsService.new(slots).next_available_slot
    end

    private

    def select_settings(settings_type)
      device_settings = @device.settings[settings_type]
      subscription_settings = @subscription.settings[settings_type]

      subscription_settings['value'] == 'devices' ? device_settings : subscription_settings
    end

    def topics_from_settings(settings)
      all_topics = Topic.all
      followed_topics = @subscription.user.following_topics

      case settings['value']
      when 'all'
        all_topics
      when 'only'
        all_topics.where(id: settings['only'])
      when 'except'
        all_topics.where.not(id: settings['except'])
      when 'followed'
        followed_topics
      else
        all_topics
      end
    end

    def slots_from_settings(settings)
      options = (0..23).map { |h| "#{h}:00".rjust(5, '0') }

      case settings['value']
      when 'all'
        options
      when 'only'
        options & settings['only']
      when 'except'
        options - settings['except']
      else
        options
      end
    end
  end
end
