FactoryBot.define do
  factory :new_reply, class: Notifications::NewReply do
    user
    comment
  end
end
