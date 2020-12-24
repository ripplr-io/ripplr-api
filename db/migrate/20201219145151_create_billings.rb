class CreateBillings < ActiveRecord::Migration[6.0]
  def change
    create_table :billings, id: :uuid do |t|
      t.belongs_to :user, type: :uuid

      t.string :status
      t.string :product
      t.string :stripe_customer_id
      t.datetime :end_at
      t.datetime :deleted_at

      t.timestamps
    end

    add_index :billings, :deleted_at

    User.all.each(&:create_billing)
  end
end
