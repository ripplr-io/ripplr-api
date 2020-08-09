class PostSerializer < ActiveModel::Serializer
  attributes :id, :title, :body, :image, :url, :created_at,
             :rateSum, :rateUser, :commentsCount, :bookmarked

  belongs_to :topic
  belongs_to :author

  # TODO: Implement these methods
  def rateSum
    0
  end

  def rateUser
    nil
  end

  def commentsCount
    0
  end

  def bookmarked
    false
  end

  def hashtags
    []
  end
end
