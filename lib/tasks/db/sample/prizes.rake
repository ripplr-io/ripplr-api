require 'factory_bot'

namespace 'db:sample' do
  desc 'Populate the database with sample prizes'
  task prizes: :environment do
    include FactoryBot::Syntax::Methods

    puts 'TODO: Creating prizes 💻💻💻'
  end
end
