class Notification < ApplicationRecord
  belongs_to :user
  has_one :profile, through: :user

  validates :data, presence: true

  # TODO: move to interactor
  after_commit :broadcast, on: :create

  private

  def broadcast
    UserChannel.broadcast_to(user, {
      type: :new_notification,
      payload: NotificationSerializer.new(self, { include: [:profile, :author] }).serializable_hash
    })
  end
end
