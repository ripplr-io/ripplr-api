class Post < ApplicationRecord
  include Ratable
  include PgSearch::Model

  belongs_to :topic
  belongs_to :author, class_name: :User

  has_many :comments
  has_many :post_hashtags
  has_many :hashtags, through: :post_hashtags
  has_many :push_notifications, dependent: :destroy
  has_many :received_subscriptions, through: :author
  has_many :bookmarks

  validates :title, presence: true
  validates :url, presence: true
  validates :body, presence: true
  validates :image, presence: true

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
end
