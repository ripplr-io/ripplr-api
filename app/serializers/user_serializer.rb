class UserSerializer < ApplicationSerializer
  attributes :slug, :name, :bio, :supporter

  attribute :postsCount, &:posts_count
  attribute :followersCount, &:followers_count
  attribute :pointsSum, &:total_points

  attributes :bot do |object|
    object.content_sources.any?
  end

  attribute :followingCount do |object|
    object.following_users_count + object.following_topics_count + object.following_hashtags_count
  end

  attribute :avatar do |object|
    url_helpers.public_blob_url(object.avatar) if object.avatar.attached?
  end
end
