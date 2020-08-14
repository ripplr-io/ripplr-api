class Hashtag < ApplicationRecord
  has_many :post_hashtags
  has_many :posts, through: :post_hashtags
  has_many :followers, class_name: :Follow, as: :followable

  validates :name, presence: true, uniqueness: true
end
