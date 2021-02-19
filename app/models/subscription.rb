class Subscription < ApplicationRecord
  belongs_to :user
  belongs_to :subscribable, polymorphic: true

  has_many :subscription_inboxes, dependent: :destroy
  has_many :inboxes, through: :subscription_inboxes, dependent: :destroy

  validates :subscribable_id, uniqueness: { scope: [:subscribable_type, :user_id] }
end
