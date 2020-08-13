class UserSerializer < ActiveModel::Serializer
  attributes :id, :slug, :name, :avatar, :bio, :supporter, :pointsSum, :followersCount, :followingCount, :postsCount, :level

  # TODO: Implement these methods
  def level
    Level.first
  end

  def supporter
    0
  end

  def pointsSum
    object.received_ratings.sum(:points)
  end

  def postsCount
    object.posts.count
  end

  def followersCount
    0
  end

  def followingCount
    0
  end
end
