class Subscription < ApplicationRecord
  belongs_to :user
  belongs_to :subscribable, polymorphic: true

  has_many :push_notifications, dependent: :destroy

  validates :settings, presence: true
end
