class CreateProposals < ActiveRecord::Migration[7.1]
  def change
    create_table :proposals do |t|
      t.references :order, null: false, foreign_key: true
      t.references :event, null: false, foreign_key: true
      t.references :event_cost, null: false, foreign_key: true
      t.integer :cost
      t.date :validate_date
      t.integer :price_change
      t.string :price_change_details
      t.string :payment
      t.integer :status

      t.timestamps
    end
  end
end
