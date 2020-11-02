class Level < ApplicationRecord
  has_many :users

  validates :from, presence: true
  validates :to, presence: true
  validates :posts, presence: true
  validates :referrals, presence: true
  validates :subscriptions, presence: true
end
