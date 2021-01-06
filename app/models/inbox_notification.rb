class InboxNotification < ApplicationRecord
  belongs_to :inbox_item
  belongs_to :inbox_channel

  validates :inbox_item_id, uniqueness: { scope: [:inbox_channel_id] }
end
