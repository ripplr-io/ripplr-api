module Devices
  class CreateService < Resources::CreateService
    def initialize(attributes)
      super(Device.new(attributes))
    end

    def save
      success = @resource.save
      Mixpanel::TrackDeviceCreatedWorker.perform_async(@resource.id) if success
      success
    end
  end
end
