class TopicSerializer < ActiveModel::Serializer
  attributes :id, :name, :slug, :avatar, :description, :created_at, :postsCount, :followersCount

  def postsCount
    object.posts.count
  end

  # TODO: Replace these methods once relashionships are in place
  def followersCount
    0
  end
end
