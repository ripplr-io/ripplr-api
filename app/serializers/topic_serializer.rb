class TopicSerializer < ApplicationSerializer
  cache_options store: Rails.cache, namespace: 'jsonapi-serializer', expires_in: 10.minutes

  attributes :name, :slug, :avatar, :description, :created_at

  attribute :postsCount, &:posts_count
  attribute :followersCount, &:followers_count
end
