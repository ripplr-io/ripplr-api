class User < ApplicationRecord
  extend FriendlyId
  include Followable
  include Subscribable
  include PgSearch::Model

  attribute :avatar_url, :string

  belongs_to :level
  has_one_attached :avatar

  has_one :billing, dependent: :destroy
  has_many :content_sources, dependent: :destroy
  has_many :comments, inverse_of: :author, foreign_key: :author_id, dependent: :destroy
  has_many :communities, inverse_of: :owner, foreign_key: :owner_id, dependent: :restrict_with_error
  has_many :notifications, dependent: :destroy
  has_many :posts, inverse_of: :author, foreign_key: :author_id, dependent: :destroy
  has_many :prizes, dependent: :destroy
  has_many :tickets, dependent: :destroy
  has_many :access_tokens, foreign_key: :resource_owner_id, class_name: 'Doorkeeper::AccessToken', dependent: :destroy

  # Channels
  has_many :channels, dependent: :destroy
  has_many :channel_devices, through: :channels, source: :channelable, source_type: 'Channel::Device'
  has_many :channel_emails, through: :channels, source: :channelable, source_type: 'Channel::Email'

  # Ratings
  has_many :ratings, dependent: :destroy
  has_many :received_ratings, through: :posts, source: :ratings

  # Follows
  has_many :follows, dependent: :destroy
  has_many :following_hashtags, through: :follows, source: :followable, source_type: 'Hashtag'
  has_many :following_topics, through: :follows, source: :followable, source_type: 'Topic'
  has_many :following_users, through: :follows, source: :followable, source_type: 'User'
  has_many :following_communities, through: :follows, source: :followable, source_type: 'Community'
  has_many :following_hashtag_posts, through: :following_hashtags, source: :posts
  has_many :following_topic_posts, through: :following_topics, source: :posts
  has_many :following_user_posts, through: :following_users, source: :posts
  has_many :following_community_posts, through: :following_communities, source: :posts

  # Subscriptions
  has_many :subscriptions, dependent: :destroy
  has_many :subscribing_users, through: :subscriptions, source: :user
  has_many :inboxes, dependent: :destroy
  has_many :inbox_channels, dependent: :destroy

  # Bookmarks
  has_many :bookmarks, dependent: :destroy
  has_many :bookmark_folders, dependent: :destroy

  # Referrals
  has_many :referrals, inverse_of: :inviter, foreign_key: :inviter_id, dependent: :destroy
  has_many :referred_users, through: :referrals, source: :invitee
  has_one :referral, inverse_of: :invitee, foreign_key: :invitee_id, dependent: :nullify
  has_one :referee, through: :referral, source: :inviter

  validates :name, presence: true
  validates :slug, presence: true, uniqueness: true
  validates :timezone, presence: true # TODO: Add inclusion
  validates :subscribed_to_marketing, inclusion: { in: [true, false] }

  acts_as_paranoid
  friendly_id :name, use: :slugged

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  pg_search_scope :search,
    using: { tsearch: { prefix: true, any_word: true } },
    against: {
      slug: 'A',
      name: 'B',
      bio: 'C'
    }

  def following_posts
    posts
      .union(following_hashtag_posts)
      .union(following_topic_posts)
      .union(following_user_posts)
      .union(following_community_posts)
      .distinct
  end

  def root_bookmark_folder
    bookmark_folders.find_by(name: 'Root')
  end

  # FIXME: Move this to the queries or decorators folder
  def total_points
    received_ratings.sum(:points) + prizes.sum(:points)
  end

  # FIXME: Move this to the queries or decorators folder
  def posts_today
    posts.where(
      created_at: Time.current.beginning_of_day..Time.current.end_of_day
    ).count
  end

  # FIXME: Move this to the queries or decorators folder
  def bot?
    content_sources.any?
  end
end
