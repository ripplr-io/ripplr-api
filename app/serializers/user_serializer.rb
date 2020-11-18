class UserSerializer < ApplicationSerializer
  attributes :slug, :name, :bio, :supporter, :level, :onboarded_at

  attribute :pointsSum do |object|
    object.total_points
  end

  attribute :postsCount do |object|
    object.posts.count
  end

  attribute :followersCount do |object|
    object.followers.count
  end

  attribute :followingCount do |object|
    object.following_users.count
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
