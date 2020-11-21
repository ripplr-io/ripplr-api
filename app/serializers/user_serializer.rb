class UserSerializer < ApplicationSerializer
  cache_options store: Rails.cache, namespace: 'jsonapi-serializer', expires_in: 10.minutes

  attributes :slug, :name, :bio, :supporter, :onboarded_at

  # FIXME: Legacy attribute - remove
  attribute :level

  attribute :postsCount, &:posts_count
  attribute :followersCount, &:followers_count
  attribute :followingCount, &:following_users_count

  attribute :pointsSum do |object|
    object.total_points
  end

  attribute :accountInfo do |object|
    {
      email: object.email,
      country: object.country,
      timezone: object.timezone,
      postsToday: object.posts_today
    }
  end

  attribute :avatar do |object|
    url_helpers.public_blob_url(object.avatar) if object.avatar.attached?
  end
end
