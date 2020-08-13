require 'factory_bot'

namespace 'db:sample' do
  desc 'Populate the database with sample ratings'
  task ratings: :environment do
    include FactoryBot::Syntax::Methods

    puts 'Creating ratings 🌟🌟🌟'

    users = User.all.to_a

    posts = Post.all.to_a
    20.times do
      create(:rating, user: users.sample, ratable: posts.sample)
    end

    comments = Comment.all.to_a
    20.times do
      create(:rating, user: users.sample, ratable: comments.sample)
    end
  end
end
