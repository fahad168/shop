class CreateCartItems < ActiveRecord::Migration[6.0]
  def change
    create_table :cart_items do |t|
      t.references :cart, null: true, foreign_key: true
      t.references :product, null: false, foreign_key: true
      t.references :variant, null: false, foreign_key: true
      t.references :size, null: false, foreign_key: true
      t.integer :quantity
      t.float :amount, default: 0.0
      t.string :color
      t.timestamps
    end
  end
end