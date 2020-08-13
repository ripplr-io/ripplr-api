require 'factory_bot'

namespace 'db:sample' do
  desc 'Populate the database with sample comments'
  task comments: :environment do
    include FactoryBot::Syntax::Methods

    puts 'Creating comments 💬💬💬'

    users = User.all
    posts = Post.all

    20.times do
      create(:comment, author: users.sample, post: posts.sample)
    end
  end
end
