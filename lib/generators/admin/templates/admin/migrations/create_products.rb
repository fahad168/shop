class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.references :shop, null: true, foreign_key: true
      t.references :user, null: true, foreign_key: true
      t.string :name
      t.float :price
      t.string :categories, array: true, default: []
      t.text :description
      t.float :discount
      t.string :estimated_delivery_days
      t.string :return_eligibility_days
      t.string :care_instructions
      t.string :item_weight
      t.string :item_dimensions
      t.string :country

      t.timestamps
    end
  end
end