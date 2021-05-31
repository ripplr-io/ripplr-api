class Notification
  class NewRating < ApplicationRecord
    include Notifiable

    belongs_to :ratable, polymorphic: true

    def to_data
      {
        type: 'post_points_update',
        post_id: ratable_id,
        points: ratable.ratings_points_total
      }
    end
  end
end
