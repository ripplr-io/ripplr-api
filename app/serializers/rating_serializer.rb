class RatingSerializer < ActiveModel::Serializer
  attributes :points, :ratable_id, :ratable_type, :created_at
end
