# TODO: Add post relashionship
class Topic < ApplicationRecord
  extend FriendlyId

  has_many :posts

  friendly_id :name, use: :slugged

  validates :name, presence: true
  validates :avatar, presence: true
  validates :slug, presence: true, uniqueness: true
end
