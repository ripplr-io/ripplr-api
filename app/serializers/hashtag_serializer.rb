class HashtagSerializer < ApplicationSerializer
  attributes :name, :created_at

  attribute :postsCount, &:posts_count
  attribute :followersCount, &:followers_count
end
