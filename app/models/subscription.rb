class Subscription < ApplicationRecord
  belongs_to :user
  belongs_to :subscribable, polymorphic: true

  has_many :push_notifications, dependent: :destroy
  has_many :subscription_inboxes, dependent: :destroy
  has_many :inboxes, through: :subscription_inboxes # TODO: validate it has at least one

  validates :subscribable_id, uniqueness: { scope: [:subscribable_type, :user_id] }
end
