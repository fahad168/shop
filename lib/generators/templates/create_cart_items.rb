class CreateCartItems < ActiveRecord::Migration[6.0]
  def change
    create_table :cart_items do |t|
      t.references :cart, null: false, foreign_key: true
      t.references :product, null: true, foreign_key: true
      t.references :variant, null: true, foreign_key: true
      t.references :size, null: true, foreign_key: true
      t.integer :quantity
      t.float :amount

      t.timestamps
    end
  end
end