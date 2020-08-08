class TopicSerializer < ActiveModel::Serializer
  attributes :id, :name, :slug, :avatar, :description, :created_at, :postsCount, :followersCount

  # TODO: Replace these methods once relashionships are in place
  def postsCount
    0
  end

  def followersCount
    0
  end
end
