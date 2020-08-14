class User < ApplicationRecord
  extend FriendlyId

  has_many :comments, inverse_of: :author, foreign_key: :author_id
  has_many :follows
  has_many :following_hashtags, through: :follows, source: :followable, source_type: :Hashtag
  has_many :following_topics, through: :follows, source: :followable, source_type: :Topic
  has_many :following_users, through: :follows, source: :followable, source_type: :User
  has_many :followers, class_name: :Follow, as: :followable
  has_many :posts, inverse_of: :author, foreign_key: :author_id
  has_many :ratings
  has_many :received_ratings, through: :posts, source: :ratings

  validates :name, presence: true
  validates :slug, presence: true, uniqueness: true

  friendly_id :name, use: :slugged

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: Devise::JWT::RevocationStrategies::Null
end
