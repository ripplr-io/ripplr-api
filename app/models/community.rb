class Community < ApplicationRecord
  extend FriendlyId

  belongs_to :owner, class_name: 'User'
  has_one_attached :image

  has_many :community_topics, dependent: :destroy
  has_many :topics, through: :community_topics

  has_many :community_posts, dependent: :destroy
  has_many :posts, through: :community_posts

  validates :community_topics, presence: true
  validates :name, presence: true, length: { maximum: 20 }
  validates :slug, presence: true, length: { maximum: 500 }, uniqueness: true
  validates :description, presence: true, length: { maximum: 500 }

  friendly_id :name, use: :slugged
end
