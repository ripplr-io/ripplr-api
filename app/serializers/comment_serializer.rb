class CommentSerializer < ActiveModel::Serializer
  attributes :id, :body, :post_id, :comment_id, :repliesCount, :created_at

  belongs_to :author

  # TODO: Implement these methods
  def comment_id
    object.parent_id
  end

  def repliesCount
    object.comments.count
  end
end
