class CommentSerializer < ApplicationSerializer
  belongs_to :profile, key: :author
  belongs_to :post
  belongs_to :comment

  attributes :body, :created_at

  attribute :repliesCount, &:replies_count

  # FIXME: Legacy attributes - remove
  attribute :post_id
  attribute :comment_id
end
