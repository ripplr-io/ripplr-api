require 'factory_bot'

namespace 'db:sample' do
  desc 'Populate the database with sample devices'
  task devices: :environment do
    include FactoryBot::Syntax::Methods

    puts 'TODO: Creating devices 💻💻💻'
  end
end
