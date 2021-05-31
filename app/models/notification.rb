class Notification < ApplicationRecord
  delegated_type :notifiable, types: Notifiable::TYPES, validate: true, dependent: :destroy

  belongs_to :user
  has_one :profile, through: :user

  # TODO: move to interactor
  after_commit :broadcast, on: :create

  private

  class << self
    def timestamp_attributes_for_create
      super << :last_activity_at.to_s
    end
  end

  def broadcast
    UserChannel.broadcast_to(user, {
      type: :new_notification,
      payload: NotificationSerializer.new(self, { include: [:profile, :author] }).serializable_hash
    })
  end
end
