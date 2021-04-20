module Trackers
  class TrackInboxItemArchiveWorker < BaseWorker
    EVENT_NAME_ARCHIVED = 'InboxItem Archived'.freeze
    EVENT_NAME_UNARCHIVED = 'InboxItem Unarchived'.freeze

    def perform(inbox_item_id)
      inbox_item = InboxItem.find_by(id: inbox_item_id)
      return if inbox_item.blank?

      event_name = inbox_item.archived_at.present? ? EVENT_NAME_ARCHIVED : EVENT_NAME_UNARCHIVED
      Analytics.track(inbox_item.inbox.user, event_name)
    end
  end
end
