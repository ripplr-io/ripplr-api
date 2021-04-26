class Profile < ApplicationRecord
  extend FriendlyId
  include PgSearch::Model
  include Followable

  delegated_type :profilable, types: Profilable::TYPES, touch: true

  has_one_attached :avatar

  validates :name, presence: true
  validates :slug, presence: true, uniqueness: true

  acts_as_paranoid
  friendly_id :name, use: :slugged

  pg_search_scope :search,
    using: { tsearch: { prefix: true, any_word: true } },
    against: {
      slug: 'A',
      name: 'B',
      bio: 'C'
    }

  def posts
    user.posts
  end

  def user_followers
    user.followers
  end

  def follows
    user.follows
  end
end
