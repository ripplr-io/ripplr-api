class HashtagSerializer < ActiveModel::Serializer
  attributes :id, :name, :created_at, :postsCount, :followersCount

  def postsCount
    object.posts.count
  end

  def followersCount
    0
  end
end
