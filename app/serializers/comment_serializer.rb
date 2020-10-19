class CommentSerializer < ActiveModel::Serializer
  attributes :body, :repliesCount, :created_at

  belongs_to :author
  belongs_to :post
  belongs_to :comment

  def repliesCount
    object.comments.count
  end
end
