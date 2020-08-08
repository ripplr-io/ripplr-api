class Post < ApplicationRecord
  belongs_to :topic
  belongs_to :author, class_name: :User

  validates_presence_of :title, :url, :body, :image
end
