class Notification < ApplicationRecord
  belongs_to :user

  validates :data, presence: true

  after_commit :broadcast, on: :create

  private

  def broadcast
    UserChannel.broadcast_to(user, {
      type: :new_notification,
      payload: NotificationSerializer.new(self, { include: [:user, :author]})
    })
  end
end
