class AddDeletedAtToProfiles < ActiveRecord::Migration[6.1]
  def change
    add_column :profiles, :deleted_at, :datetime
    add_index :profiles, :deleted_at
  end
end
