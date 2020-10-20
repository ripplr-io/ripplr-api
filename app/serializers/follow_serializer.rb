class FollowSerializer < ActiveModel::Serializer
  attributes :followable_type, :followable_id, :created_at

  def followable_type
    object.followable_type.downcase
  end
end