require 'factory_bot'

namespace 'db:sample' do
  desc 'Populate the database with sample bookmarks'
  task bookmarks: :environment do
    include FactoryBot::Syntax::Methods

    puts 'Creating bookmarks 🔖🔖🔖'

    root_bookmark_folder = User.first.root_bookmark_folder
    posts = Post.all.to_a

    folders = create_list(:bookmark_folder, 4, bookmark_folder: root_bookmark_folder, user: root_bookmark_folder.user)

    2.times do
      create(:bookmark, post: posts.sample, bookmark_folder: root_bookmark_folder)
    end

    5.times do
      create(:bookmark, post: posts.sample, bookmark_folder: folders.sample)
    end
  end
end
