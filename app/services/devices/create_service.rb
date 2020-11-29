module Devices
  class CreateService < Resources::BaseService
    def save
      success = @resource.save
      Mixpanel::TrackDeviceCreatedWorker.perform_async(@resource.id) if success
      success
    end
  end
end
