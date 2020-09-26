class BookmarkFolder < ApplicationRecord
  belongs_to :user
  belongs_to :bookmark_folder, optional: true

  has_many :bookmark_folders
  has_many :bookmarks

  validates :name, presence: true
end
