class Follow < ApplicationRecord
  belongs_to :followable, polymorphic: true
  belongs_to :user

  validates :followable_id, uniqueness: { scope: [:followable_type, :user_id] }

  counter_culture :followable, column_name: :followers_count, touch: true
  counter_culture :user, touch: true,
    column_name: proc { |model| model.followable_type == :User ? :following_users_count : nil },
    column_names: {
      Follow.where(followable_type: :User) => :following_users_count
    }
end
