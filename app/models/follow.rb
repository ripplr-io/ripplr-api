class Follow < ApplicationRecord
  belongs_to :followable, polymorphic: true
  belongs_to :user

  validates :followable_id, uniqueness: { scope: [:followable_type, :user_id] }
end
