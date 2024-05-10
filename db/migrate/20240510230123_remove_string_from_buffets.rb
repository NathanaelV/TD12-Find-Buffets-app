class RemoveStringFromBuffets < ActiveRecord::Migration[7.1]
  def change
    remove_column :buffets, :string, :string
  end
end
