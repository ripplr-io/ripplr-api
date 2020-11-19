class Follow < ApplicationRecord
  belongs_to :followable, polymorphic: true
  belongs_to :user

  validates :followable_id, uniqueness: { scope: [:followable_type, :user_id] }

  counter_culture :followable, column_name: :followers_count, touch: true
  counter_culture :user, column_name: :following_count, touch: true
end
