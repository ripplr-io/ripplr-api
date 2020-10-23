class CreateTickets < ActiveRecord::Migration[6.0]
  def change
    create_table :tickets, id: :uuid do |t|
      t.belongs_to :user, type: :uuid
      t.string :title, null: false
      t.text :body, null: false

      t.timestamps
    end
  end
end
