class CreateFollows < ActiveRecord::Migration[6.0]
  def change
    create_table :follows, id: :uuid do |t|
      t.references :followable, type: :uuid, polymorphic: true
      t.belongs_to :user, type: :uuid

      t.timestamps
    end
  end
end
