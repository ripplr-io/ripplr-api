module Segment
  class TrackInboxCreatedWorker < BaseWorker
    EVENT_NAME = 'Inbox Created'.freeze

    def perform(inbox_id)
      inbox = Inbox.find_by(id: inbox_id)
      return if inbox.blank?

      Segment::TrackService.new.call(inbox.user, EVENT_NAME)
    end
  end
end
