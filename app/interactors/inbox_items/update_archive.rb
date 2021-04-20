module InboxItems
  class UpdateArchive < ApplicationInteractor
    def call
      context.fail! unless context.resource.save

      Trackers::TrackInboxItemArchiveWorker.perform_async(context.resource.id)
    end
  end
end
