FactoryBot.define do
  factory :post do
    author factory: :user
    topic

    title { Faker::Games::LeagueOfLegends.quote }
    url { Faker::Internet.url }
    body { Faker::Lorem.paragraph }

    # TODO: Explore a source for random images
    image { 'https://images.unsplash.com/photo-1596824893185-851980de8938?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1350&q=80' }
  end
end
