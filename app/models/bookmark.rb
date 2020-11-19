class Bookmark < ApplicationRecord
  belongs_to :post, touch: true
  belongs_to :user
  belongs_to :bookmark_folder

  validates :post_id, uniqueness: { scope: :user_id }

  counter_culture :bookmark_folder, touch: true
end
