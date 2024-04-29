class CreateEventCosts < ActiveRecord::Migration[7.1]
  def change
    create_table :event_costs do |t|
      t.string :description, null: false
      t.integer :minimum, null: false
      t.integer :additional_per_person
      t.integer :overtime
      t.references :event, null: false, foreign_key: true

      t.timestamps
    end
  end
end
