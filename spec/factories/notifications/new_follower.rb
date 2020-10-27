FactoryBot.define do
  factory :new_follower, class: Notifications::NewFollower do
    user
    follower factory: :user
  end
end
