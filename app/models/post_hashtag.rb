class PostHashtag < ApplicationRecord
  belongs_to :post
  belongs_to :hashtag

  validates :hashtag_id, uniqueness: { scope: :post_id }

  acts_as_paranoid
end
