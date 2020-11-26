class CommentSerializer < ApplicationSerializer
  cache_options store: Rails.cache, namespace: 'jsonapi-serializer', expires_in: 10.minutes

  belongs_to :author, serializer: :user
  belongs_to :post
  belongs_to :comment

  attributes :body, :created_at

  attribute :repliesCount, &:replies_count

  # FIXME: Legacy attributes - remove
  attribute :comment_id
end
