if Rails.env.development?
  require 'factory_bot'

  class SampleData
    include FactoryBot::Syntax::Methods

    def generate_all
      puts 'Creating admin user 👷'
      user = create(:user, email: 'admin@ripplr.io', password: '123456')

      puts '- with devices 💻💻💻'
      create_list(:device, 3, user: user)

      puts '- with tickets 🎟🎟🎟'
      create_list(:ticket, 3, user: user)

      puts '- with bookmark folders 📂📂📂'
      create_list(:bookmark_folder, 3, user: user, bookmark_folder: user.root_bookmark_folder)

      puts '- with pending referrals 🙅🙅🙅'
      create_list(:referral, 3, inviter: user)

      puts '- with accepted referrals 🙆🙆🙆'
      create_list(:referral, 3, :with_invitee, inviter: user)

      puts 'Creating other users 🤷🤷🤷'
      create_list(:user, 10)

      puts 'Creating hashtags #️⃣#️⃣#️⃣'
      create_list(:hashtag, 10)

      users = User.all.to_a
      topics = Topic.all.to_a
      hashtags = Hashtag.all.to_a

      puts 'Creating follows 🔭🔭🔭'
      create_follows(users, topics, hashtags)

      puts 'Creating subscriptions 📅📅📅'
      create_subscriptions(users)

      puts 'Creating posts 📜📜📜'
      create_posts(users, topics, hashtags)

      posts = Post.all.to_a

      puts 'Creating ratings 🌟🌟🌟'
      create_ratings(users, posts)

      puts 'Creating comments 💬💬💬'
      create_comments(users, posts)

      comments = Comment.all.to_a

      puts 'Creating replies 🗯🗯🗯'
      create_replies(users, comments)

      puts 'Creating bookmarks 🔖🔖🔖'
      create_bookmarks(users, posts)
    end

    private

    def create_follows(users, topics, hashtags)
      users.each do |user|
        other_users = users.dup - [user]
        rand(0..5).times do
          create(:follow, user: user, followable: other_users.shuffle!.pop)
        end

        other_topics = topics.dup
        rand(0..5).times do
          create(:follow, user: user, followable: other_topics.shuffle!.pop)
        end

        other_hashtags = hashtags.dup
        rand(0..5).times do
          create(:follow, user: user, followable: other_hashtags.shuffle!.pop)
        end
      end
    end

    def create_subscriptions(users)
      users.each do |user|
        other_users = users.dup - [user]
        rand(0..5).times do
          create(:subscription, user: user, subscribable: other_users.shuffle!.pop)
        end
      end
    end

    def create_posts(users, topics, hashtags)
      users.each do |user|
        rand(0..5).times do
          create(:post, author: user, topic: topics.sample, hashtags: hashtags.sample(rand(0..4)))
        end
      end
    end

    def create_ratings(users, posts)
      users.each do |user|
        other_posts = posts.dup
        rand(0..5).times do
          create(:rating, user: user, ratable: other_posts.shuffle!.pop)
        end
      end
    end

    def create_comments(users, posts)
      users.each do |user|
        other_posts = posts.dup
        rand(0..5).times do
          create(:comment, author: user, post: other_posts.shuffle!.pop)
        end
      end
    end

    def create_replies(users, comments)
      users.each do |user|
        other_comments = comments.dup
        rand(0..5).times do
          create(:reply, author: user, comment: other_comments.shuffle!.pop)
        end
      end
    end

    def create_bookmarks(users, posts)
      users.each do |user|
        other_posts = posts.dup
        folders = user.bookmark_folders.to_a
        rand(0..5).times do
          create(:bookmark, user: user, bookmark_folder: folders.sample, post: other_posts.shuffle!.pop)
        end
      end
    end
  end
end
