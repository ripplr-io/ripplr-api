class Prize < ApplicationRecord
  belongs_to :prizable, polymorphic: true
  belongs_to :user

  validates :name, presence: true
  validates :points, presence: true

  enum onboarding_prizes: {
    follow: 'First Follow',
    rating: 'First Rating',
    device: 'First Device',
    post: 'First Post',
    subscription: 'First Subscription',
    referral: 'First Referral',
    completed: 'Completed Onboarding Bonus',
  }
end
