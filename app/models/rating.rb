class Rating < ApplicationRecord
  belongs_to :ratable, polymorphic: true
  belongs_to :user

  validates :points, presence: true, inclusion: { in: [0, 1, 3, 5, 8] }
  validates :ratable_id, uniqueness: { scope: [:ratable_type, :user_id] }

  acts_as_paranoid
  counter_culture :ratable, column_name: :ratings_points_total, delta_column: :points, touch: true
end
