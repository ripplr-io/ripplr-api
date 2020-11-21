class CommentSerializer < ApplicationSerializer
  cache_options store: Rails.cache, namespace: 'jsonapi-serializer', expires_in: 10.minutes

  attributes :body, :created_at

  # FIXME: Legacy attribute - remove
  attribute :post_id

  # FIXME: Legacy attribute - remove
  attribute :comment_id

  belongs_to :author, serializer: :user
  belongs_to :post
  belongs_to :comment

  attribute :repliesCount, &:replies_count
end
