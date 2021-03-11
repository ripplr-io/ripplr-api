class Follow < ApplicationRecord
  belongs_to :followable, polymorphic: true
  belongs_to :user

  validates :followable_id, uniqueness: { scope: [:followable_type, :user_id] }

  counter_culture :followable, column_name: :followers_count, touch: true
  counter_culture(:user, touch: true,
    column_names: {
      Follow.where(followable_type: :User) => :following_users_count,
      Follow.where(followable_type: :Topic) => :following_topics_count,
      Follow.where(followable_type: :Hashtag) => :following_hashtags_count,
      Follow.where(followable_type: :Community) => :following_communities_count
    },
    column_name: proc do |model|
      next :following_users_count if model.followable_type == 'User'
      next :following_topics_count if model.followable_type == 'Topic'
      next :following_hashtags_count if model.followable_type == 'Hashtag'
      next :following_communities_count if model.followable_type == 'Community'
    end
  )
end
