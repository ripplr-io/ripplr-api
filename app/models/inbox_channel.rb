class InboxChannel < ApplicationRecord
  belongs_to :user
  belongs_to :inbox
  belongs_to :channel

  has_many :inbox_notifications, dependent: :destroy

  validates :inbox_id, uniqueness: { scope: :channel_id }
  validates_with InboxChannels::UserValidator
end
