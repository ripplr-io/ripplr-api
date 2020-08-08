class Level < ApplicationRecord
  validates :from, presence: true
  validates :to, presence: true
  validates :posts, presence: true
  validates :referrals, presence: true
  validates :subscriptions, presence: true
end
