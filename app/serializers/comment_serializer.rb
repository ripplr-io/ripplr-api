class CommentSerializer < ApplicationSerializer
  attributes :body, :created_at, :post_id, :comment_id

  belongs_to :author, serializer: :user
  belongs_to :post
  belongs_to :comment

  attribute :repliesCount do |object|
    object.comments.count
  end
end
