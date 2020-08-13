class Rating < ApplicationRecord
  belongs_to :ratable, polymorphic: true
  belongs_to :user

  validates :points, presence: true
end
