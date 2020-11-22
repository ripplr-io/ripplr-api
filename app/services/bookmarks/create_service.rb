module Bookmarks
  class CreateService < Resources::CreateService
    def initialize(attributes)
      super(Bookmark.new(attributes))
    end

    def save
      success = @resource.save
      Mixpanel::TrackBookmarkCreatedWorker.perform_async(@resource.id) if success
      success
    end
  end
end
