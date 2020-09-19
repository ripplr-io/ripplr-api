class PushNotification < ApplicationRecord
  belongs_to :post
  belongs_to :device
  belongs_to :subscription

  validates :title, presence: true
  validates :body, presence: true
  validates :thumbnail, presence: true
end
