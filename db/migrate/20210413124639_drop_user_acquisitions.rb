class DropUserAcquisitions < ActiveRecord::Migration[6.1]
  def up
    drop_table :user_acquisitions
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
