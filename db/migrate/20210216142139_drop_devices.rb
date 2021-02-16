class DropDevices < ActiveRecord::Migration[6.1]
  def up
    drop_table :devices
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
