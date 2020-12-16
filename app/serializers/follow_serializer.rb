class FollowSerializer < ApplicationSerializer
  belongs_to :followable, polymorphic: true
  attributes :created_at
end
