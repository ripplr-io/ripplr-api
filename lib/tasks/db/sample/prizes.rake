require 'factory_bot'

namespace 'db:sample' do
  desc 'Populate the database with sample prizes'
  task prizes: :environment do
    include FactoryBot::Syntax::Methods

    puts 'Creating prizes 🎁🎁🎁'

    referrals = Referral.where.not(invitee: nil)

    referrals.each do |referral|
      create(:prize, prizable: referral)
    end
  end
end
