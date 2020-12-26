class Inbox < ApplicationRecord
  belongs_to :user
  has_many :subscription_inboxes, dependent: :destroy
  has_many :subscriptions, through: :subscription_inboxes
  # has_many :inbox_items

  validates :name, presence: true
  validates :settings, presence: true
end
