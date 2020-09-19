class Post < ApplicationRecord
  belongs_to :topic
  belongs_to :author, class_name: :User

  has_many :comments
  has_many :ratings, as: :ratable
  has_many :post_hashtags
  has_many :hashtags, through: :post_hashtags
  has_many :push_notifications, dependent: :destroy
  has_many :subscribers, through: :author

  validates :title, presence: true
  validates :url, presence: true
  validates :body, presence: true
  validates :image, presence: true

  after_create_commit :generate_push_notifications

  private

  def generate_push_notifications
  end
end
