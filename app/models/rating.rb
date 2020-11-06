class Rating < ApplicationRecord
  belongs_to :ratable, polymorphic: true
  belongs_to :user

  validates :points, presence: true, inclusion: { in: [0, 1, 3, 5, 8] }
  validates :ratable_id, uniqueness: { scope: [:ratable_type, :user_id] }
end
