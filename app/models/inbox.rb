class Inbox < ApplicationRecord
  belongs_to :user

  has_many :subscription_inboxes, dependent: :destroy
  has_many :subscriptions, through: :subscription_inboxes
  has_many :inbox_items, dependent: :destroy
  has_many :posts, through: :inbox_items, source: :inboxable, source_type: 'Post'
  has_many :inbox_channels, dependent: :destroy
  has_many :channels, through: :inbox_channels

  validates :settings, presence: true
  validates :name, presence: true
  validates :name, uniqueness: { scope: :user_id }

  accepts_nested_attributes_for :inbox_channels, allow_destroy: true
end
