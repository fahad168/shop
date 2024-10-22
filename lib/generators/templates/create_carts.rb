class CreateCarts < ActiveRecord::Migration[6.0]
  def change
    create_table :carts do |t|
      t.references :user, null: false, foreign_key: true
      t.float :total_amount, default: 0.0
      t.timestamps
    end
  end
end