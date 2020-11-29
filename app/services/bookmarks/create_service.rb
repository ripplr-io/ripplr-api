module Bookmarks
  class CreateService < Resources::BaseService
    def save
      success = @resource.save
      Mixpanel::TrackBookmarkCreatedWorker.perform_async(@resource.id) if success
      success
    end
  end
end
