class User < ApplicationRecord
  extend FriendlyId

  has_many :comments, inverse_of: :author, foreign_key: :author_id
  has_many :devices
  has_many :notifications
  has_many :posts, inverse_of: :author, foreign_key: :author_id
  has_many :ratings
  has_many :received_ratings, through: :posts, source: :ratings
  has_many :followers, class_name: :Follow, as: :followable

  # Follow
  has_many :follows
  has_many :following_hashtags, through: :follows, source: :followable, source_type: :Hashtag
  has_many :following_topics, through: :follows, source: :followable, source_type: :Topic
  has_many :following_users, through: :follows, source: :followable, source_type: :User
  has_many :following_hashtag_posts, through: :following_hashtags, source: :posts
  has_many :following_topic_posts, through: :following_topics, source: :posts
  has_many :following_user_posts, through: :following_users, source: :posts

  validates :name, presence: true
  validates :slug, presence: true, uniqueness: true

  friendly_id :name, use: :slugged

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: Devise::JWT::RevocationStrategies::Null

  def following_posts
    all_posts = following_hashtag_posts.union(following_topic_posts).union(following_user_posts)
    all_posts.distinct.order(created_at: :desc)
  end
end
