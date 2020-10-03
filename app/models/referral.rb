class Referral < ApplicationRecord
  belongs_to :inviter, class_name: :User
  belongs_to :invitee, class_name: :User, optional: true

  validates :name, presence: true
  validates :email, presence: true
end
