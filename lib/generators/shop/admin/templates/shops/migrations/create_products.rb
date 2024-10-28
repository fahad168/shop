class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.references :shop, null: false, foreign_key: true
      t.string :name
      t.float :price
      t.text :description
      t.float :delivery_fee
      t.string :country

      t.timestamps
    end
  end
end