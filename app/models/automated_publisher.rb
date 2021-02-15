class AutomatedPublisher < ApplicationRecord
  belongs_to :topic
  belongs_to :user

  validates :feed_url, presence: true
end
