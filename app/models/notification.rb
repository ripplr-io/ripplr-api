class Notification < ApplicationRecord
  enum notification_type: {
    new_comment: 'NewComment',
    new_reply: 'NewReply',
    new_level: 'NewLevel',
    new_follower: 'NewFollower',
    referral_accepted: 'ReferralAccepted'
  }

  belongs_to :user

  validates :notification_type, presence: true
  validates :data, presence: true
end
