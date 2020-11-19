class CommentSerializer < ApplicationSerializer
  cache_options store: Rails.cache, namespace: 'jsonapi-serializer', expires_in: 10.minutes

  attributes :body, :created_at, :post_id, :comment_id

  belongs_to :author, serializer: :user
  belongs_to :post
  belongs_to :comment

  attribute :repliesCount, &:replies_count
end
