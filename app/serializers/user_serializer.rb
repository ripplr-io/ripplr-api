class UserSerializer < ApplicationSerializer
  has_one :profile

  attributes :supporter

  attribute :postsCount, &:posts_count
  attribute :pointsSum, &:total_points
  attribute :bot, &:bot?

  attribute :followingCount do |object|
    object.following_profiles_count + object.following_topics_count + object.following_hashtags_count
  end

  attribute :avatar do |object|
    url_helpers.public_blob_url(object.profile.avatar) if object.profile.avatar.attached?
  end

  attribute :slug do |object|
    object.profile.slug
  end

  attribute :name do |object|
    object.profile.name
  end

  attribute :bio do |object|
    object.profile.bio
  end
end
