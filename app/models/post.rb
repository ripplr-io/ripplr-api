class Post < ApplicationRecord
  include Ratable
  include Inboxable
  include PgSearch::Model

  DEFAULT_IMAGE = 'https://cdn.ripplr.io/brand/logo-black.png'.freeze

  belongs_to :topic
  belongs_to :author, class_name: 'User'
  has_one_attached :image

  has_many :bookmarks, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :post_hashtags, dependent: :destroy
  has_many :hashtags, through: :post_hashtags

  # Followers
  has_many :topic_followers, through: :topic, source: :followers
  has_many :author_followers, through: :author, source: :followers
  has_many :hashtag_followers, through: :hashtags, source: :followers

  # Subscriptions
  has_many :subscriptions, through: :author, source: :received_subscriptions
  has_many :candidate_inboxes, through: :subscriptions, source: :inboxes

  validates :title, presence: true
  validates :url, presence: true
  validates :body, presence: true

  acts_as_paranoid
  counter_culture :topic, touch: true
  counter_culture :author, touch: true

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
    topic_followers.union(author_followers).union(hashtag_followers).union(authors)
  end
end
