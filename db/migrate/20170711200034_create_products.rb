class CreateProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :products do |t|
      t.string :title
      t.text :description
      t.float :price
      t.float :sale_price
      t.integer :hit_count

      t.timestamps
    end
  end
end
