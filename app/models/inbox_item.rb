class InboxItem < ApplicationRecord
  belongs_to :inbox
  belongs_to :inboxable, polymorphic: true

  has_many :inbox_notifications, dependent: :destroy

  validates :inboxable_id, uniqueness: { scope: [:inboxable_type, :inbox_id] }

  scope :archived, lambda { |value=true|
    value ? where.not(archived_at: nil) : where(archived_at: nil)
  }
end
