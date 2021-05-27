class CreateNotificationTables < ActiveRecord::Migration[6.1]
  def change
    create_table :notification_new_comments, id: :uuid do |t|
      t.belongs_to :comment, type: :uuid

      t.timestamps
    end

    create_table :notification_new_followers, id: :uuid do |t|
      t.belongs_to :follow, type: :uuid

      t.timestamps
    end

    create_table :notification_new_levels, id: :uuid do |t|
      t.belongs_to :level, type: :uuid

      t.timestamps
    end

    create_table :notification_new_replies, id: :uuid do |t|
      t.belongs_to :comment, type: :uuid

      t.timestamps
    end

    create_table :notification_accepted_referrals, id: :uuid do |t|
      t.belongs_to :referral, type: :uuid

      t.timestamps
    end
  end
end
