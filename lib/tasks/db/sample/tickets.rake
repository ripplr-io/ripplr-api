require 'factory_bot'

namespace 'db:sample' do
  desc 'Populate the database with sample tickets'
  task tickets: :environment do
    include FactoryBot::Syntax::Methods

    puts 'TODO: Creating tickets 💻💻💻'
  end
end
