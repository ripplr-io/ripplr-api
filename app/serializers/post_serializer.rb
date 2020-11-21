class PostSerializer < ApplicationSerializer
  cache_options store: Rails.cache, namespace: 'jsonapi-serializer', expires_in: 10.minutes

  DEFAULT_POST_IMAGE = 'https://cdn.ripplr.io/brand/logo-black.png'.freeze

  attributes :title, :body, :image, :url, :created_at

  belongs_to :topic
  belongs_to :author, record_type: :user, serializer: :user
  has_many :hashtags

  attribute :commentsCount, &:comments_count
  attribute :rateSum, &:ratings_points_total

  attribute :rateUser do |object, params|
    current_user = params[:current_user]
    next nil if current_user.blank?

    rating = object.ratings.find_by(user: current_user)
    next nil if rating.nil?

    { points: rating.points }
  end

  belongs_to :bookmark do |object, params|
    current_user = params[:current_user]
    next nil if current_user.blank?

    current_user.bookmarks.find_by(post_id: object.id)
  end

  attribute :image do |object|
    object.image.attached? ? url_helpers.public_blob_url(object.image) : DEFAULT_POST_IMAGE
  end

  # FIXME: Legacy attribute - remove
  attributes :author do |object|
    object.author.as_json
  end

  # FIXME: Legacy attribute - remove
  attributes :topic do |object|
    object.topic.as_json
  end

  # FIXME: Legacy attribute - remove
  attributes :hashtags do |object|
    object.hashtags.as_json
  end
end
