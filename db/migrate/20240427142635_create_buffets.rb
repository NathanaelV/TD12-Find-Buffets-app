class CreateBuffets < ActiveRecord::Migration[7.1]
  def change
    create_table :buffets do |t|
      t.string :brand_name
      t.string :corporate_name
      t.string :registration_number
      t.string :phone
      t.string :email
      t.string :address
      t.string :string
      t.string :city
      t.string :state
      t.string :zip_code
      t.string :description
      t.string :payment
      t.references :owner, null: false, foreign_key: true

      t.timestamps
    end
  end
end
