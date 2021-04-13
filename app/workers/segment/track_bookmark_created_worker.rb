module Segment
  class TrackBookmarkCreatedWorker < BaseWorker
    EVENT_NAME = 'Bookmark Created'.freeze

    def perform(bookmark_id)
      bookmark = Bookmark.find_by(id: bookmark_id)
      return if bookmark.blank?

      Segment::TrackService.new.call(bookmark.user, EVENT_NAME)
    end
  end
end
