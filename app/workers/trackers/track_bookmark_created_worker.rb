module Trackers
  class TrackBookmarkCreatedWorker < BaseWorker
    EVENT_NAME = 'Bookmark Created'.freeze

    def perform(bookmark_id)
      bookmark = Bookmark.find_by(id: bookmark_id)
      return if bookmark.blank?

      Analytics.track(bookmark.user, EVENT_NAME)
    end
  end
end
