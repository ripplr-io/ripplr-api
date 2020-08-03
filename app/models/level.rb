class Level < ApplicationRecord
  validates_presence_of :name, :from, :to, :posts, :referrals, :subscriptions
end
