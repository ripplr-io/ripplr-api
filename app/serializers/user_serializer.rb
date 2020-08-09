class UserSerializer < ActiveModel::Serializer
  attributes :id, :slug, :name, :avatar, :bio, :supporter, :pointsSum, :followersCount, :followingCount, :postsCount, :level

  def level
    Level.first
  end

  # TODO: Implement these methods
  def slug
    'ggraca'
  end

  def name
    'Guilherme Graca'
  end

  def avatar
    "https:\/\/ripplr.ams3.digitaloceanspaces.com\/user\/048758bd-51fd-4ad5-9615-ccefd0ba7205\/d1ebef2c-f576-40da-ab8f-39c075772621.jpg"
  end

  def bio
    nil
  end

  def supporter
    0
  end

  def pointsSum
    0
  end

  def postsCount
    0
  end

  def followersCount
    0
  end

  def followingCount
    0
  end
end
