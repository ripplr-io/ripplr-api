require 'factory_bot'

namespace 'db:sample' do
  desc 'Populate the database with sample users'
  task users: :environment do
    include FactoryBot::Syntax::Methods

    puts 'Creating users 🤷🤷🤷'

    create(:user, email: 'admin@ripplr.io', password: '123456')
    create(:user, email: 'poster@ripplr.io', password: '123456')

    create_list(:user, 5)
  end
end
