FactoryBot.define do
  factory :notification_new_follower, class: Notification::NewFollower do
    follow
  end
end
