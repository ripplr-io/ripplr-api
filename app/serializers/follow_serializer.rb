class FollowSerializer < ApplicationSerializer
  cache_options store: Rails.cache, namespace: 'jsonapi-serializer', expires_in: 10.minutes

  attributes :followable_id, :created_at

  attribute :followable_type do |object|
    object.followable_type.downcase
  end
end
