FactoryBot.define do
  factory :new_comment, class: Notifications::NewComment do
    user
    comment
  end
end
