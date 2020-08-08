# TODO: Add post relashionship
class Topic < ApplicationRecord
  extend FriendlyId

  has_many :posts

  friendly_id :name, use: :slugged
  validates_presence_of :name, :avatar, :slug
  validates_uniqueness_of :slug
end
