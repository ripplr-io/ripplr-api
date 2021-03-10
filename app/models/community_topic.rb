class CommunityTopic < ApplicationRecord
  belongs_to :community
  belongs_to :topic

  validates :topic_id, uniqueness: { scope: :community_id }
end
