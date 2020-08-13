class CommentSerializer < ActiveModel::Serializer
  attributes :id, :body, :post_id, :comment_id, :repliesCount, :created_at

  belongs_to :author

  def repliesCount
    object.comments.count
  end
end
