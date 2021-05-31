class Level < ApplicationRecord
  has_many :users, dependent: :restrict_with_error
  has_many :notification_new_levels, class_name: 'Notification::NewLevel', dependent: :destroy

  validates :from, presence: true
  validates :to, presence: true
  validates :posts, presence: true
  validates :referrals, presence: true
  validates :subscriptions, presence: true
  validates :inboxes, presence: true
end
