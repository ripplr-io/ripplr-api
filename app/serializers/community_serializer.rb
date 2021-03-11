class CommunitySerializer < ApplicationSerializer
  belongs_to :owner, serializer: :user
  has_many :topics

  attributes :name, :slug, :description, :created_at

  attribute :postsCount, &:posts_count
  attribute :followersCount, &:followers_count

  attribute :image do |object|
    url_helpers.public_blob_url(object.image) if object.image.attached?
  end
end
