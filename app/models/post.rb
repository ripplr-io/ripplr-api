class Post < ApplicationRecord
  include Ratable

  belongs_to :topic
  belongs_to :author, class_name: :User

  has_many :comments
  has_many :post_hashtags
  has_many :hashtags, through: :post_hashtags
  has_many :push_notifications, dependent: :destroy
  has_many :received_subscriptions, through: :author

  validates :title, presence: true
  validates :url, presence: true
  validates :body, presence: true
  validates :image, presence: true

  after_create_commit :generate_push_notifications

  private

  def generate_push_notifications
    Posts::GeneratePushNotificationsWorker.perform_async(id)
  end
end
