class AddBotAttributeToProfiles < ActiveRecord::Migration[6.1]
  def up
    add_column :profiles, :bot, :boolean, default: false

    Profile.all.each do |profile|
      profile.bot = profile.user.content_sources.any?
      profile.save!
    end
  end

  def down
    remove_column :profiles, :bot
  end
end
