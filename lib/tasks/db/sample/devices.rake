require 'factory_bot'

namespace 'db:sample' do
  desc 'Populate the database with sample devices'
  task devices: :environment do
    include FactoryBot::Syntax::Methods

    puts 'Creating devices 💻💻💻'

    users = User.all.to_a

    5.times do
      create(:device, user: users.sample)
    end
  end
end
