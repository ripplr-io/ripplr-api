module Devices
  class CreateService < Resources::BaseService
    def save
      success = @resource.save
      if success
        Mixpanel::TrackDeviceCreatedWorker.perform_async(@resource.id)
        Prizes::Onboarding::FirstDeviceWorker.perform_async(@resource.user.id)
      end
      success
    end
  end
end
