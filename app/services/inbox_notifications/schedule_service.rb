module InboxNotifications
  class ScheduleService
    def initialize(inbox_notification)
      @inbox_notification = inbox_notification

      inbox_channel_settings = @inbox_notification.inbox_channel.settings
      channel_settings = @inbox_notification.inbox_channel.channel.settings
      @settings = inbox_channel_settings || channel_settings
    end

    def next_available_slot
      slots = slots_from_settings(@settings['availability'])

      Time.use_zone(timezone) do
        SettingsSlotsService.new(slots).next_available_slot
      end
    end

    private

    def slots_from_settings(settings)
      options = (0..23).map { |h| "#{h}:00".rjust(5, '0') }
      return options if settings.blank?

      case settings['value']
      when 'only'
        options & settings['only']
      when 'except'
        options - settings['except']
      else # NOTE: by default, any other value will behave as 'all'
        options
      end
    end

    def timezone
      @inbox_notification.inbox_channel.channel.user.timezone
    end
  end
end
