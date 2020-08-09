FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { Faker::Internet.password }
    name { Faker::Movies::LordOfTheRings.character }
    bio { Faker::Lorem.paragraph }
    avatar { "https:\/\/ripplr.ams3.digitaloceanspaces.com\/user\/048758bd-51fd-4ad5-9615-ccefd0ba7205\/d1ebef2c-f576-40da-ab8f-39c075772621.jpg" }
  end
end
