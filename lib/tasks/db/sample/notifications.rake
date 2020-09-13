require 'factory_bot'

namespace 'db:sample' do
  desc 'Populate the database with sample notifications'
  task notifications: :environment do
    include FactoryBot::Syntax::Methods

    puts 'TODO: Creating notifications 📬📬📬'
  end
end
