class Notification < ApplicationRecord
  belongs_to :user

  validates :data, presence: true

  after_commit :broadcast, on: :create

  private

  def broadcast
    ActionCable.server.broadcast "notifications_#{user.id}", as_json
  end
end
