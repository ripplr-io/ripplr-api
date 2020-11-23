class FollowSerializer < ApplicationSerializer
  cache_options store: Rails.cache, namespace: 'jsonapi-serializer', expires_in: 10.minutes

  belongs_to :followable, polymorphic: true
  attributes :created_at

  # FIXME: Legacy attributes - remove
  attribute :followable_id
  attribute :followable_type do |object|
    object.followable_type.downcase
  end
end
