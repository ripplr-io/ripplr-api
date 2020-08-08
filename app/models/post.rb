class Post < ApplicationRecord
  belongs_to :topic
  belongs_to :author, class_name: :User

  validates :title, presence: true
  validates :url, presence: true
  validates :body, presence: true
  validates :image, presence: true
end
