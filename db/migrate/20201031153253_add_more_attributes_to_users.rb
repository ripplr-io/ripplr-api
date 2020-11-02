class AddMoreAttributesToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :timezone, :string, null: false, default: 'UTC'
    add_column :users, :country, :string
    add_column :users, :onboarded_at, :datetime
    add_column :users, :supporter, :boolean, null: false, default: false
    add_reference :users, :level, type: :uuid
  end
end
