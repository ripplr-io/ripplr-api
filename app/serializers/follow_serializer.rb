class FollowSerializer < ApplicationSerializer
  cache_options store: Rails.cache, namespace: 'jsonapi-serializer', expires_in: 10.minutes

  belongs_to :followable, polymorphic: true
  attributes :created_at
end
