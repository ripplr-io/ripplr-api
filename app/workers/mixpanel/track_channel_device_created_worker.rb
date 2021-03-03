module Mixpanel
  class TrackChannelDeviceCreatedWorker < BaseWorker
    EVENT_NAME = 'Device Created'.freeze

    def perform(channel_device_id)
      channel_device = Channel::Device.find_by(id: channel_device_id)
      return if channel_device.blank?

      Mixpanel::BaseService.new(channel_device.channel.user).track(EVENT_NAME)
    end
  end
end
