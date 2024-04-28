class CreateEvents < ActiveRecord::Migration[7.1]
  def change
    create_table :events do |t|
      t.string :name
      t.string :description
      t.integer :min_people
      t.integer :max_people
      t.integer :duration
      t.string :menu
      t.boolean :alcoholic_beverages
      t.boolean :decoration
      t.boolean :parking
      t.boolean :parking_valet
      t.boolean :customer_space
      t.references :buffet, null: false, foreign_key: true

      t.timestamps
    end
  end
end
