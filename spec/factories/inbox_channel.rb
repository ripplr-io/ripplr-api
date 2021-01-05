FactoryBot.define do
  factory :inbox_channel do
    user
    inbox { association :inbox, user: user }
    channel { association :channel, user: user }
  end
end
