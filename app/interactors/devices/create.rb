module Devices
  class Create < ApplicationInteractor
    def call
      context.fail! unless context.resource.save

      Mixpanel::TrackDeviceCreatedWorker.perform_async(context.resource.id)
      Prizes::Onboarding::FirstDeviceWorker.perform_async(context.resource.user.id)
    end
  end
end
