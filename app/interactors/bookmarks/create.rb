module Bookmarks
  class Create < ApplicationInteractor
    def call
      context.fail! unless context.resource.save

      Mixpanel::TrackBookmarkCreatedWorker.perform_async(context.resource.id)
    end
  end
end
