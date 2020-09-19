class Hashtag < ApplicationRecord
  include Followable

  has_many :post_hashtags
  has_many :posts, through: :post_hashtags

  validates :name, presence: true, uniqueness: true
end
