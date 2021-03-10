class CommunityPost < ApplicationRecord
  belongs_to :community
  belongs_to :post

  validates :post_id, uniqueness: { scope: :community_id }
end
