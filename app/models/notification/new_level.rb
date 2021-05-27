class Notification
  class NewLevel < ApplicationRecord
    include Notifiable

    belongs_to :level
    has_one :user, through: :notification

    def to_data
      {
        type: 'new_level',
        id: user_id,
        level: level.as_json
      }
    end
  end
end
