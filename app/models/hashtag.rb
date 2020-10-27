class Hashtag < ApplicationRecord
  include Followable
  include PgSearch::Model

  has_many :post_hashtags
  has_many :posts, through: :post_hashtags

  validates :name, presence: true, uniqueness: true

  pg_search_scope :search,
    using: { tsearch: { prefix: true, any_word: true } },
    against: :name
end
