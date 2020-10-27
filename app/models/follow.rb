class Follow < ApplicationRecord
  belongs_to :followable, polymorphic: true
  belongs_to :user

  after_commit :generate_create_notification, on: :create

  private

  def generate_create_notification
    return unless followable_type == 'User'

    Notifications::NewFollower.create(user: followable, follower: user)
  end
end
