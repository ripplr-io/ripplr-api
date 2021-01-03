class Channel < ApplicationRecord
  delegated_type :channelable, types: ['Channel::Email', 'Channel::Device'], dependent: :destroy

  belongs_to :user

  validates :settings, presence: true
  validates :name, presence: true
  validates :name, uniqueness: { scope: :user_id }
end
