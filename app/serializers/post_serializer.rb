class PostSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers

  DEFAULT_POST_IMAGE = 'https://cdn.ripplr.io/brand/logo-black.png'.freeze

  attributes :title, :body, :image, :url, :created_at, :rateSum, :rateUser,
    :commentsCount, :bookmarked, :author, :topic, :hashtags

  belongs_to :topic
  belongs_to :author
  has_many :hashtags

  def rateSum
    object.ratings.sum(:points)
  end

  def rateUser
    return nil if scope.blank?

    rating = object.ratings.find_by(user: scope)
    return nil if rating.nil?

    { points: rating.points }
  end

  def commentsCount
    object.comments.where(comment: nil).count
  end

  def bookmarked
    return nil if scope.blank?

    scope.bookmarks.find_by(post_id: object.id).present?
  end

  def image
    object.image.attached? ? url_for(object.image) : DEFAULT_POST_IMAGE
  end
end
