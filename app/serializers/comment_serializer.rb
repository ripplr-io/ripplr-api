class CommentSerializer < ActiveModel::Serializer
  attributes :id, :body, :post_id, :comment_id, :repliesCount, :created_at

  belongs_to :author

  # TODO: Implement these methods
  def comment_id
    nil
  end

  def repliesCount
    0
  end
end
