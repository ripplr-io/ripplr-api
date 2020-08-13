require 'factory_bot'

namespace 'db:sample' do
  desc 'Populate the database with sample posts'
  task posts: :environment do
    include FactoryBot::Syntax::Methods

    puts 'Creating posts 📜📜📜'

    users = User.all
    topics = Topic.all

    20.times do
      create(:post, author: users.sample, topic: topics.sample)
    end
  end
end
