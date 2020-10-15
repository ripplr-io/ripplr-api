require 'factory_bot'

namespace 'db:sample' do
  desc 'Populate the database with sample subscriptions'
  task subscriptions: :environment do
    include FactoryBot::Syntax::Methods

    puts 'Creating subscriptions 📅📅📅'

    users = User.all.to_a

    5.times do
      create(:subscription, user: users.sample, subscribable: users.sample)
    end
  end
end
