module Mixpanel
  class TrackBookmarkCreatedWorker < BaseWorker
    EVENT_NAME = 'Bookmark Created'.freeze

    def perform(bookmark_id)
      bookmark = Bookmark.find_by(id: bookmark_id)
      return if bookmark.blank?

      Mixpanel::BaseService.new(bookmark.user.id).track(EVENT_NAME)
    end
  end
end
