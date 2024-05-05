class CreateOrders < ActiveRecord::Migration[7.1]
  def change
    create_table :orders do |t|
      t.string :code
      t.integer :status, default: 0
      t.date :event_date
      t.integer :people
      t.string :details
      t.string :address
      t.references :buffet, null: false, foreign_key: true
      t.references :customer, null: false, foreign_key: true
      t.references :event, null: false, foreign_key: true

      t.timestamps
    end
  end
end
