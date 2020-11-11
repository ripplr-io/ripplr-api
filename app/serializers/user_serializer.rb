class UserSerializer < ActiveModel::Serializer
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
end
