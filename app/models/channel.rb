class Channel < ApplicationRecord
  delegated_type :channelable, types: Channelable::TYPES, validate: true, dependent: :destroy

  belongs_to :user

  has_many :inbox_channels, dependent: :destroy
  has_many :inboxes, through: :inbox_channels

  validates :settings, presence: true, allow_blank: true
  validates :name, presence: true
  validates :name, uniqueness: { scope: :user_id }
end
