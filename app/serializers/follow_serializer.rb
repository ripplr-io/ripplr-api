class FollowSerializer < ApplicationSerializer
  attributes :followable_id, :created_at

  attribute :followable_type do |object|
    object.followable_type.downcase
  end
end
