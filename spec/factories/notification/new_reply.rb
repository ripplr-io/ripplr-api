FactoryBot.define do
  factory :notification_new_reply, class: Notification::NewReply do
    comment { association :reply }
  end
end
