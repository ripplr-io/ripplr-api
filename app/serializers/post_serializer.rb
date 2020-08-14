class PostSerializer < ActiveModel::Serializer
  attributes :id, :title, :body, :image, :url, :created_at,
             :rateSum, :rateUser, :commentsCount, :bookmarked

  belongs_to :topic
  belongs_to :author
  has_many :hashtags

  # TODO: Implement these methods
  def rateSum
    object.ratings.sum(:points)
  end

  def rateUser
    nil
  end

  def commentsCount
    object.comments.count
  end

  def bookmarked
    false
  end
end
