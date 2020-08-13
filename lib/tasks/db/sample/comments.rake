require 'factory_bot'

namespace 'db:sample' do
  desc 'Populate the database with sample comments'
  task comments: :environment do
    include FactoryBot::Syntax::Methods

    puts 'Creating comments 💬💬💬'

    users = User.all.to_a
    posts = Post.all.to_a

    20.times do
      create(:comment, author: users.sample, post: posts.sample)
    end

    puts 'Creating replies 🗯🗯🗯'

    comments = Comment.all.to_a
    20.times do
      create(:reply, author: users.sample, parent: comments.sample)
    end
  end
end
