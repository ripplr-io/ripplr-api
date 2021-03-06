class ProfileSerializer < ApplicationSerializer
  belongs_to :user

  attributes :name, :slug, :bio, :bot
  attribute :followersCount, &:followers_count
  attribute :postsCount, &:posts_count

  attribute :avatar do |object|
    url_helpers.public_blob_url(object.avatar) if object.avatar.attached?
  end

  attribute :supporter do |object|
    object.user.supporter
  end

  attribute :pointsSum do |object|
    object.user.total_points
  end

  attribute :followingCount do |object|
    [object.user.following_profiles_count, object.user.following_topics_count, object.user.following_hashtags_count].sum
  end
end
