class InboxItem < ApplicationRecord
  belongs_to :inbox
  belongs_to :inboxable, polymorphic: true

  has_many :inbox_notifications, dependent: :destroy

  validates :inboxable_id, uniqueness: { scope: [:inboxable_type, :inbox_id] }

  # TODO: Add endpoints to change this value (/inbox_item/:id/archive)
  scope :not_archived, -> { where(archived_at: nil) }
end
