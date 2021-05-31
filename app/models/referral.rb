class Referral < ApplicationRecord
  include Prizable

  belongs_to :inviter, class_name: 'User'
  belongs_to :invitee, class_name: 'User', optional: true

  has_many :notification_accepted_referrals, class_name: 'Notification::AcceptedReferral', dependent: :destroy

  transforms :email, strip: true, downcase: true

  validates :name, presence: true
  validates :email, presence: true, email: true

  validates :email, uniqueness: { scope: :inviter_id }
  validates :invitee_id, uniqueness: { scope: :inviter_id }, allow_nil: true
end
