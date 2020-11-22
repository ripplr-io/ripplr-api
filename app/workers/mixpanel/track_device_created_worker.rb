module Mixpanel
  class TrackDeviceCreatedWorker < BaseWorker
    EVENT_NAME = 'Device Created'.freeze

    def perform(device_id)
      device = Device.find_by(id: device_id)
      return if device.blank?

      Mixpanel::BaseService.new(device.user.id).track(EVENT_NAME)
    end
  end
end
