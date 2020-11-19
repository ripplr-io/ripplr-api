class HashtagSerializer < ApplicationSerializer
  cache_options store: Rails.cache, namespace: 'jsonapi-serializer', expires_in: 10.minutes

  attributes :name, :created_at

  # NOTE: Will be outdated until next cache refresh
  attribute :postsCount do |object|
    object.posts.count
  end

  # NOTE: Will be outdated until next cache refresh
  attribute :followersCount do |object|
    object.followers.count
  end
end
