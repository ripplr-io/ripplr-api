class HashtagSerializer < ActiveModel::Serializer
  attributes :id, :name, :created_at, :postsCount, :followersCount

  def postsCount
    object.posts.count
  end

  def followersCount
    object.followers.count
  end
end
