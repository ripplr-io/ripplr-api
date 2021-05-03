module Followable
  extend ActiveSupport::Concern

  included do
    has_many :received_follows, as: :followable, class_name: 'Follow', dependent: :destroy
    has_many :followers, through: :received_follows, source: :user
    has_many :follower_profiles, through: :followers, source: :profile
  end
end
