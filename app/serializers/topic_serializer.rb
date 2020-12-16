class TopicSerializer < ApplicationSerializer
  attributes :name, :slug, :avatar, :description, :created_at

  attribute :postsCount, &:posts_count
  attribute :followersCount, &:followers_count
end
