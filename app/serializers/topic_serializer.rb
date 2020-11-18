class TopicSerializer < ApplicationSerializer
  attributes :name, :slug, :avatar, :description, :created_at

  attribute :postsCount do |object|
    object.posts.count
  end

  attribute :followersCount do |object|
    object.followers.count
  end
end
