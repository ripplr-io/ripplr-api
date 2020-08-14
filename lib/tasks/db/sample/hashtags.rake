require 'factory_bot'

namespace 'db:sample' do
  desc 'Populate the database with sample hashtags'
  task hashtags: :environment do
    include FactoryBot::Syntax::Methods

    puts 'Creating hashtags #️⃣#️⃣#️⃣'

    create_list(:hashtag, 10)

    posts = Post.all.to_a
    hashtags = Hashtag.all.to_a

    hashtags.each do |hashtag|
      repetitions = (0..3).to_a.sample
      repetitions.times do
        PostHashtag.create(hashtag: hashtag, post: posts.sample)
      end
    end
  end
end
