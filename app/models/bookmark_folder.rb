class BookmarkFolder < ApplicationRecord
  belongs_to :user
  belongs_to :bookmark_folder, optional: true

  has_many :bookmark_folders, dependent: :destroy
  has_many :bookmarks, dependent: :restrict_with_error

  validates :name, presence: true
  validates :name, uniqueness: { scope: [:bookmark_folder_id, :user_id] }

  counter_culture :bookmark_folder, touch: true
end
