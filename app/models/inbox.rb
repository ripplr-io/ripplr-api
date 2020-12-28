# TODO: Add unique to name/user ?
class Inbox < ApplicationRecord
  belongs_to :user
  has_many :subscription_inboxes, dependent: :destroy
  has_many :subscriptions, through: :subscription_inboxes
  has_many :inbox_items, class_name: 'Inbox::Item', dependent: :destroy
  has_many :posts, through: :inbox_items, source: :inboxable, source_type: 'Post'

  validates :name, presence: true
  validates :settings, presence: true
end
