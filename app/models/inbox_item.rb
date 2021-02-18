class InboxItem < ApplicationRecord
  belongs_to :inbox
  belongs_to :inboxable, polymorphic: true

  has_many :inbox_notifications, dependent: :destroy

  validates :inboxable_id, uniqueness: { scope: [:inboxable_type, :inbox_id] }

  scope :archived, lambda { |value = true|
    value ? where.not(archived_at: nil) : where(archived_at: nil)
  }

  counter_culture :inbox, touch: true
  counter_culture :inbox, touch: true,
    column_name: proc { |model| model.archived_at.blank? ? nil : :inbox_items_archived_count },
    column_names: {
      InboxItem.where.not(archived_at: nil) => :inbox_items_archived_count
    }
end
