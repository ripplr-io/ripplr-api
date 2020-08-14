require 'factory_bot'

namespace 'db:sample' do
  desc 'Populate the database with sample follows'
  task follows: :environment do
    include FactoryBot::Syntax::Methods

    puts 'Creating follows 🔭🔭🔭'

    users = User.all.to_a
    topics = Topic.all.to_a
    hashtags = Hashtag.all.to_a

    users.each do |user|
      create(:follow, :for_user, user: user, followable: users.sample)
      create(:follow, :for_topic, user: user, followable: topics.sample)
      create(:follow, :for_hashtag, user: user, followable: hashtags.sample)
    end
  end
end
