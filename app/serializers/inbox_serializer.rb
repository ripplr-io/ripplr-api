class InboxSerializer < ApplicationSerializer
  attributes :name, :settings, :description, :inbox_items_count, :inbox_items_archived_count, :subscription_inboxes_count

  attribute :inbox_items_not_archived_count do |object|
    object.inbox_items_count - object.inbox_items_archived_count
  end

  has_many :inbox_channels
end
