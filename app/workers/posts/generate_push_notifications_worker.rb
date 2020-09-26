module Posts
  class GeneratePushNotificationsWorker
    include Sidekiq::Worker

    def perform(post_id)
      post = Post.find(post_id)
      all_topics = Topic.all.ids

      post.received_subscriptions.each do |subscription|
        devices = subscription.user.devices
        devices = filter_devices(devices, subscription.settings['devices'])

        followed_topics = subscription.user.following_topic_ids
        devices.each do |device|
          topic_settings = select_settings(subscription, device, 'topics')
          topics = filter_topics(all_topics, followed_topics, topic_settings)
          next unless topics.include?(post.topic_id)

          availability_settings = select_settings(subscription, device, 'availability')
          available_slots = filter_availability(availability_settings)

          schedule_time = find_next_available_slot(available_slots)

          device.push_notifications.create!(
            post: post,
            subscription: subscription,
            title: "#{post.author.name} has shared a new post",
            body: post.body,
            thumbnail: "https://ripplr.ams3.digitaloceanspaces.com/brand/logo-black.png",
            scheduled_to: schedule_time
          )
        end
      end
    end

    private

    def select_settings(subscription, device, settings_type)
      device_settings = device.settings[settings_type]
      subscription_settings = subscription.settings[settings_type]

      subscription_settings['value'] == 'devices' ? device_settings : subscription_settings
    end

    def filter_devices(devices, settings)
      case settings['value']
      when 'all'
        devices
      when 'only'
        devices.where(id: settings['only'])
      when 'except'
        devices.where.not(id: settings['except'])
      else
        devices
      end
    end

    def filter_topics(all_topics, followed_topics, settings)
      case settings['value']
      when 'all'
        all_topics
      when 'only'
        all_topics & settings['only']
      when 'except'
        all_topics - settings['except']
      when 'followed'
        followed_topics
      else
        all_topics
      end
    end

    def filter_availability(settings)
      options = (0..23).map{ |h| "#{h}:00".rjust(5, '0') }

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

    def find_next_available_slot(slots)
      # Slots are originally in the format '10:00'
      hours_of_day = slots.map{ |h| h[0,2].to_i.hours }.sort

      # Slots today
      hours_of_day.each do |hour|
        time = Time.current.beginning_of_day + hour
        return time if time >= Time.current.beginning_of_hour
      end

      # First slot tomorrow
      Time.current.beginning_of_day + 1.day + hours_of_day.first
    end
  end
end
