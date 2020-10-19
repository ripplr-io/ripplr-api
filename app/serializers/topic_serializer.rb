class TopicSerializer < ActiveModel::Serializer
  attributes :name, :slug, :avatar, :description, :created_at, :postsCount, :followersCount

  def postsCount
    object.posts.count
  end

  def followersCount
    object.followers.count
  end
end
