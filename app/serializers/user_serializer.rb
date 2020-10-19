class UserSerializer < ActiveModel::Serializer
  attributes :slug, :name, :avatar, :bio, :supporter, :pointsSum,
             :followersCount, :followingCount, :postsCount, :level, :onboarded_at

  def level
    Level.first # TODO
  end

  def supporter
    0 # TODO
  end

  def pointsSum
    object.received_ratings.sum(:points)
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

  def onboarded_at
    DateTime.now # TODO
  end
end
