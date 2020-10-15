require 'factory_bot'

namespace 'db:sample' do
  desc 'Populate the database with sample tickets'
  task tickets: :environment do
    include FactoryBot::Syntax::Methods

    puts 'Creating tickets 🎟🎟🎟'

    users = User.all.to_a

    5.times do
      create(:ticket, user: users.sample)
    end
  end
end
