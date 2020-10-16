class User < ApplicationRecord
  extend FriendlyId
  include Followable
  include Subscribable

  has_many :comments, inverse_of: :author, foreign_key: :author_id
  has_many :devices
  has_many :notifications
  has_many :posts, inverse_of: :author, foreign_key: :author_id
  has_many :tickets

  # Ratings
  has_many :ratings
  has_many :received_ratings, through: :posts, source: :ratings

  # Follows
  has_many :follows
  has_many :following_hashtags, through: :follows, source: :followable, source_type: :Hashtag
  has_many :following_topics, through: :follows, source: :followable, source_type: :Topic
  has_many :following_users, through: :follows, source: :followable, source_type: :User
  has_many :following_hashtag_posts, through: :following_hashtags, source: :posts
  has_many :following_topic_posts, through: :following_topics, source: :posts
  has_many :following_user_posts, through: :following_users, source: :posts

  # Subscriptions
  has_many :subscriptions
  has_many :subscribing_users, through: :subscriptions, source: :user

  # Bookmarks
  has_many :bookmark_folders
  has_many :bookmarks, through: :bookmark_folders, source: :bookmarks

  # Referrals
  has_many :referrals, inverse_of: :inviter, foreign_key: :inviter_id
  has_many :referred_users, through: :referrals, source: :invitee
  has_one :referral, inverse_of: :invitee, foreign_key: :invitee_id
  has_one :referee, through: :referral, source: :inviter

  validates :name, presence: true
  validates :slug, presence: true, uniqueness: true

  after_create_commit :create_root_bookmark_folder

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

  def root_bookmark_folder
    bookmark_folders.find_by(name: 'Root')
  end

  private

  def create_root_bookmark_folder
    bookmark_folders.create!(name: 'Root')
  end
end
