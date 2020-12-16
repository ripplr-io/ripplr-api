class RatingSerializer < ApplicationSerializer
  belongs_to :ratable, polymorphic: true

  attributes :points, :created_at
end
