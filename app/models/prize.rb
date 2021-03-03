class Prize < ApplicationRecord
  belongs_to :prizable, polymorphic: true, optional: true
  belongs_to :user, touch: true

  validates :name, presence: true
  validates :points, presence: true

  REFERRAL_PRIZES = {
    created: { name: 'Referral Created', points: 10 },
    accepted: { name: 'Referral Accepted', points: 50 }
  }.freeze

  ONBOARDING_PRIZES = {
    follow: { name: 'First Follow', points: 50 },
    rating: { name: 'First Rating', points: 50 },
    device: { name: 'First Device', points: 50 },
    post: { name: 'First Post', points: 150 },
    subscription: { name: 'First Subscription', points: 150 },
    inbox: { name: 'First Inbox', points: 150 },
    referral: { name: 'First Referral', points: 150 },
    completed: { name: 'Onboarding Completed Bonus', points: 200 }
  }.freeze
end
