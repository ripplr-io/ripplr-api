require 'factory_bot'

namespace 'db:sample' do
  desc 'Populate the database with sample referrals'
  task referrals: :environment do
    include FactoryBot::Syntax::Methods

    puts 'TODO: Creating referrals 💻💻💻'
  end
end
