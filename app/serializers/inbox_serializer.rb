class InboxSerializer < ApplicationSerializer
  attributes :name, :settings, :description, :inbox_items_count, :inbox_items_archived_count, :subscription_inboxes_count

  has_many :inbox_channels
end
