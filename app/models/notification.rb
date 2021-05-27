class Notification < ApplicationRecord
  # TODO: Remove after migration
  self.inheritance_column = :_type_disabled

  delegated_type :notifiable, types: Notifiable::TYPES, validate: true, dependent: :destroy

  belongs_to :user
  has_one :profile, through: :user

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
