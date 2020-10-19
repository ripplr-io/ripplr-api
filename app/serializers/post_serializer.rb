class PostSerializer < ActiveModel::Serializer
  attributes :title, :body, :image, :url, :created_at,
             :rateSum, :rateUser, :commentsCount, :bookmarked, :author, :topic, :hashtags

  belongs_to :topic
  belongs_to :author
  has_many :hashtags

  def rateSum
    object.ratings.sum(:points)
  end

  def rateUser
    nil # TODO
  end

  def commentsCount
    object.comments.count
  end

  def bookmarked
    false # TODO: scope.bookmarks.find_by(post_id: object.id).present?
  end
end
