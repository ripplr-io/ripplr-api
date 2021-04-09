class CreateUserAcquisitions < ActiveRecord::Migration[6.1]
  def change
    create_table :user_acquisitions, id: :uuid do |t|
      t.belongs_to :user, type: :uuid
      t.string :medium
      t.string :source
      t.string :campaign

      t.timestamps
    end
  end
end
