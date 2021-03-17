class Community < ApplicationRecord
  extend FriendlyId
  include Followable
  include PgSearch::Model

  belongs_to :owner, class_name: 'User'
  has_one_attached :avatar

  has_many :community_topics, dependent: :destroy
  has_many :topics, through: :community_topics
  has_many :content_sources, dependent: :restrict_with_error

  has_many :community_posts, dependent: :destroy
  has_many :posts, through: :community_posts

  validates :community_topics, presence: true
  validates :name, presence: true, length: { maximum: 20 }
  validates :slug, presence: true, length: { maximum: 500 }, uniqueness: true
  validates :description, presence: true, length: { maximum: 500 }

  friendly_id :name, use: :slugged

  pg_search_scope :search,
    using: { tsearch: { prefix: true, any_word: true } },
    against: :name,
    order_within_rank: 'posts_count DESC'
end
