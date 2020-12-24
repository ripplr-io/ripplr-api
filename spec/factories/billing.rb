FactoryBot.define do
  factory :billing do
    user { association :user, billing: instance }
  end
end
