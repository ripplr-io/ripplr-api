require 'factory_bot'

namespace 'db:sample' do
  desc 'Populate the database with sample referrals'
  task referrals: :environment do
    include FactoryBot::Syntax::Methods

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
end
