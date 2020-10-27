class Topic < ApplicationRecord
  extend FriendlyId
  include Followable
  include PgSearch::Model

  has_many :posts

  validates :name, presence: true
  validates :avatar, presence: true
  validates :slug, presence: true, uniqueness: true

  friendly_id :name, use: :slugged

  pg_search_scope :search,
    using: { tsearch: { prefix: true, any_word: true } },
    against: {
      name: 'A',
      slug: 'B'
    }
end
