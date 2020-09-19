class Topic < ApplicationRecord
  extend FriendlyId

  has_many :posts
  has_many :followers, class_name: :Follow, as: :followable

  validates :name, presence: true
  validates :avatar, presence: true
  validates :slug, presence: true, uniqueness: true

  friendly_id :name, use: :slugged
end
