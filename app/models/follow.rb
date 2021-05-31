class Follow < ApplicationRecord
  belongs_to :followable, polymorphic: true
  belongs_to :user

  has_many :notification_new_followers, class_name: 'Notification::NewFollower', dependent: :destroy

  validates :followable_id, uniqueness: { scope: [:followable_type, :user_id] }

  counter_culture :followable, column_name: :followers_count, touch: true
  counter_culture(:user, touch: true,
    column_names: {
      Follow.where(followable_type: :Profile) => :following_profiles_count,
      Follow.where(followable_type: :Topic) => :following_topics_count,
      Follow.where(followable_type: :Hashtag) => :following_hashtags_count,
      Follow.where(followable_type: :Community) => :following_communities_count
    },
    column_name: proc do |model|
      next :following_profiles_count if model.followable_type == 'Profile'
      next :following_topics_count if model.followable_type == 'Topic'
      next :following_hashtags_count if model.followable_type == 'Hashtag'
      next :following_communities_count if model.followable_type == 'Community'
    end
  )
end
