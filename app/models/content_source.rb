class ContentSource < ApplicationRecord
  belongs_to :community
  belongs_to :user

  validates :feed_url, presence: true, url: true
end
