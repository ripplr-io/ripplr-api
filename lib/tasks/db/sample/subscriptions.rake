require 'factory_bot'

namespace 'db:sample' do
  desc 'Populate the database with sample subscriptions'
  task subscriptions: :environment do
    include FactoryBot::Syntax::Methods

    puts 'TODO: Creating subscriptions 💻💻💻'
  end
end
