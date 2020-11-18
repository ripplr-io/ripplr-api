class PostSerializer < ApplicationSerializer
  DEFAULT_POST_IMAGE = 'https://cdn.ripplr.io/brand/logo-black.png'.freeze

  attributes :title, :body, :image, :url, :created_at

  belongs_to :topic
  belongs_to :author, record_type: :user, serializer: :user
  has_many :hashtags

  attribute :rateSum do |object|
    object.ratings.sum(:points)
  end

  attribute :rateUser do |object, params|
    current_user = params[:current_user]
    next nil if current_user.blank?

    rating = object.ratings.find_by(user: current_user)
    next nil if rating.nil?

    { points: rating.points }
  end

  attribute :commentsCount do |object|
    object.comments.where(comment: nil).count
  end

  attribute :bookmarked do |object, params|
    current_user = params[:current_user]
    next nil if current_user.blank?

    current_user.bookmarks.find_by(post_id: object.id).present?
  end

  attribute :image do |object|
    object.image.attached? ? url_helpers.public_blob_url(object.image) : DEFAULT_POST_IMAGE
  end

  # FIXME: Legacy author - remove
  attributes :author do |object|
    object.author.as_json
  end

  # FIXME: Legacy topic - remove
  attributes :topic do |object|
    object.topic.as_json
  end

  # FIXME: Legacy hashtags - remove
  attributes :hashtags do |object|
    object.hashtags.as_json
  end
end
