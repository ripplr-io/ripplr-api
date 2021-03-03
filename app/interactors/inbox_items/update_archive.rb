module InboxItems
  class UpdateArchive < ApplicationInteractor
    def call
      context.fail! unless context.resource.save

      Mixpanel::TrackInboxItemArchiveWorker.perform_async(context.resource.id)
    end
  end
end
