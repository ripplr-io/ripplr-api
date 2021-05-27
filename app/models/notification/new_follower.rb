class Notification
  class NewFollower < ApplicationRecord
    include Notifiable

    belongs_to :follow
    has_one :follower, through: :follow, source: :user

    def to_data
      {
        type: 'new_follower',
        author_id: follower.profile_id
      }
    end
  end
end
