if Rails.env.development?
  require 'factory_bot'

  class SampleData
    include FactoryBot::Syntax::Methods

    def generate_all
      users
      posts
      comments
      ratings
      hashtags
      devices
      follows
      subscriptions
      bookmarks
      tickets
      referrals
      prizes
    end

    def users
      puts 'Creating users 🤷🤷🤷'

      create(:user, email: 'admin@ripplr.io', password: '123456')
      create(:user, email: 'poster@ripplr.io', password: '123456')

      create_list(:user, 5)
    end

    def posts
      puts 'Creating posts 📜📜📜'

      users = User.all.to_a
      topics = Topic.all.to_a

      20.times do
        create(:post, author: users.sample, topic: topics.sample)
      end
    end

    def comments
      puts 'Creating comments 💬💬💬'

      users = User.all.to_a
      posts = Post.all.to_a

      20.times do
        create(:comment, author: users.sample, post: posts.sample)
      end

      puts 'Creating replies 🗯🗯🗯'

      comments = Comment.all.to_a
      20.times do
        create(:reply, author: users.sample, comment: comments.sample)
      end
    end

    def ratings
      puts 'Creating ratings 🌟🌟🌟'

      users = User.all.to_a

      posts = Post.all.to_a
      20.times do
        create(:rating, user: users.sample, ratable: posts.sample)
      end

      comments = Comment.all.to_a
      20.times do
        create(:rating, user: users.sample, ratable: comments.sample)
      end
    end

    def hashtags
      puts 'Creating hashtags #️⃣#️⃣#️⃣'

      create_list(:hashtag, 10)

      posts = Post.all.to_a
      hashtags = Hashtag.all.to_a

      hashtags.each do |hashtag|
        repetitions = (0..3).to_a.sample
        repetitions.times do
          PostHashtag.create(hashtag: hashtag, post: posts.sample)
        end
      end
    end

    def devices
      puts 'Creating devices 💻💻💻'

      users = User.all.to_a

      5.times do
        create(:device, user: users.sample)
      end
    end

    def follows
      puts 'Creating follows 🔭🔭🔭'

      users = User.all.to_a
      topics = Topic.all.to_a
      hashtags = Hashtag.all.to_a

      users.each do |user|
        create(:follow, :for_user, user: user, followable: users.sample)
        create(:follow, :for_topic, user: user, followable: topics.sample)
        create(:follow, :for_hashtag, user: user, followable: hashtags.sample)
      end
    end

    def subscriptions
      puts 'Creating subscriptions 📅📅📅'

      users = User.all.to_a

      5.times do
        create(:subscription, user: users.sample, subscribable: users.sample)
      end
    end

    def bookmarks
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

    def tickets
      puts 'Creating tickets 🎟🎟🎟'

      users = User.all.to_a

      5.times do
        create(:ticket, user: users.sample)
      end
    end

    def referrals
      puts 'Creating referrals 👥👥👥'

      inviter = User.first
      users = User.all.to_a.drop(1)

      5.times do
        create(:referral, inviter: inviter)
      end

      3.times do
        invitee = users.sample
        create(:referral, inviter: inviter, invitee: invitee, email: invitee, accepted_at: invitee.created_at)
      end
    end

    def prizes
      puts 'Creating prizes 🎁🎁🎁'

      referrals = Referral.where.not(invitee: nil)

      referrals.each do |referral|
        create(:prize, prizable: referral)
      end
    end
  end
end
