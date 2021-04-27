class Post < ApplicationRecord
  extend FriendlyId
  include Ratable
  include Inboxable
  include PgSearch::Model

  DEFAULT_IMAGE = 'https://cdn.ripplr.io/brand/logo-black.png'.freeze

  attribute :image_url, :string

  belongs_to :topic
  belongs_to :author, class_name: 'Profile', foreign_key: 'profile_id'
  has_one_attached :image

  has_many :bookmarks, dependent: :destroy
  has_many :comments, dependent: :destroy

  # Communities
  has_many :community_posts, dependent: :destroy
  has_many :communities, through: :community_posts

  # Hashtags
  has_many :post_hashtags, dependent: :destroy
  has_many :hashtags, through: :post_hashtags

  # Followers
  has_many :author_followers, through: :author, source: :followers
  has_many :topic_followers, through: :topic, source: :followers
  has_many :hashtag_followers, through: :hashtags, source: :followers
  has_many :community_followers, through: :communities, source: :followers

  # Subscriptions
  has_many :subscriptions, through: :author, source: :received_subscriptions
  has_many :candidate_inboxes, through: :subscriptions, source: :inboxes

  validates :title, presence: true
  validates :url, presence: true, url: true
  validates :body, presence: true
  validates :slug, presence: true, uniqueness: true

  scope :order_chronologically, -> { order(created_at: :desc) }
  scope :order_by_rating, -> { order(ratings_points_total: :desc) }
  scope :order_by_trending, -> { order(trending_score: :desc) }

  acts_as_paranoid
  counter_culture :topic, touch: true
  counter_culture :author, touch: true

  friendly_id :short_title, use: :slugged

  pg_search_scope :search,
    using: { tsearch: { prefix: true, any_word: true } },
    against: {
      title: 'A',
      body: 'B'
    },
    associated_against: {
      author: :name,
      topic: :name,
      hashtags: :name
    }

  def followers
    authors = User.where(id: author_id)

    authors
      .union(topic_followers)
      .union(author_followers)
      .union(hashtag_followers)
      .union(community_followers)
      .distinct
  end

  private

  # NOTE: Used by friendly_id to always keep the full words in the slug
  def short_title
    return title if title.blank?

    title.truncate(60, separator: /\s/, omission: '')
  end
end
