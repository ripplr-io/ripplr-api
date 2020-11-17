class UserSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers

  attributes :slug, :name, :avatar, :bio, :supporter, :pointsSum, :level,
    :followersCount, :followingCount, :postsCount, :onboarded_at, :accountInfo

  def pointsSum
    object.total_points
  end

  def postsCount
    object.posts.count
  end

  def followersCount
    object.followers.count
  end

  def followingCount
    object.following_users.count
  end

  def accountInfo
    {
      email: object.email,
      country: object.country,
      timezone: object.timezone,
      postsToday: object.posts_today
    }
  end

  def avatar
    public_blob_url(object.avatar) if object.avatar.attached?
  end
end
