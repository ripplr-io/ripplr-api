module Channels
  class Create < ApplicationInteractor
    def call
      context.fail! unless context.resource.save

      if context.resource.channel_device?
        Segment::TrackChannelDeviceCreatedWorker.perform_async(context.resource.channelable.id)
        Prizes::Onboarding::FirstDeviceWorker.perform_async(context.resource.user.id)
      end
    end
  end
end
