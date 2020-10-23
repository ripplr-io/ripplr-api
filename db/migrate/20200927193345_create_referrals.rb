class CreateReferrals < ActiveRecord::Migration[6.0]
  def change
    create_table :referrals, id: :uuid do |t|
      t.belongs_to :inviter, type: :uuid, foreign_key: { to_table: :users }
      t.belongs_to :invitee, type: :uuid, foreign_key: { to_table: :users }

      t.string :name, null: false
      t.string :email, null: false
      t.datetime :accepted_at

      t.timestamps
    end
  end
end
