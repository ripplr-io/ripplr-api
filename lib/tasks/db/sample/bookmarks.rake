require 'factory_bot'

namespace 'db:sample' do
  desc 'Populate the database with sample bookmarks'
  task bookmarks: :environment do
    include FactoryBot::Syntax::Methods

    puts 'TODO: Creating bookmarks 💻💻💻'
  end
end
