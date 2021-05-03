class CommentSerializer < ApplicationSerializer
  belongs_to :author, serializer: :profile, id_method_name: :profile_id
  belongs_to :post
  belongs_to :comment

  attributes :body, :created_at

  attribute :repliesCount, &:replies_count

  # FIXME: Legacy attributes - remove
  attribute :post_id
  attribute :comment_id
end
