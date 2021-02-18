class InboxItemSerializer < ApplicationSerializer
  attributes :created_at, :updated_at, :archived_at

  belongs_to :inbox
  belongs_to :inboxable, polymorphic: true
end
