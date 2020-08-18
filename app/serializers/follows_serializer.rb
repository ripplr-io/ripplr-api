class FollowSerializer < ActiveModel::Serializer
  attributes :id, :followable_type, :followable_id, :created_at
end
