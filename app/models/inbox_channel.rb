class InboxChannel < ApplicationRecord
  belongs_to :user
  belongs_to :inbox
  belongs_to :channel

  has_many :inbox_notifications, dependent: :destroy

  validates :inbox_id, uniqueness: { scope: :channel_id }
  validate :same_user?

  private

  def same_user?
    return if user == inbox&.user && user == channel&.user

    errors.add(:user, 'must be the same')
  end
end
