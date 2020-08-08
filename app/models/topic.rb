# TODO: Add post relashionship
class Topic < ApplicationRecord
  extend FriendlyId

  friendly_id :name, use: :slugged
  validates_presence_of :name, :avatar, :slug
  validates_uniqueness_of :slug
end
