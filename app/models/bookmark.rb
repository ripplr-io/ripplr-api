class Bookmark < ApplicationRecord
  belongs_to :post
  belongs_to :user
  belongs_to :bookmark_folder
end
