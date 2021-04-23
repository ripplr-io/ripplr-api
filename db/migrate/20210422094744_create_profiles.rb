class CreateProfiles < ActiveRecord::Migration[6.1]
  def change
    create_table :profiles, id: :uuid do |t|
      t.references :profilable, type: :uuid, polymorphic: true
      t.string :name, null: false
      t.text :bio
      t.string :slug, null: false

      t.timestamps
    end

    add_index :profiles, :slug, unique: true
  end
end
