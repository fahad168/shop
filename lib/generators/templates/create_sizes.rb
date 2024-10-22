class CreateSizes < ActiveRecord::Migration[6.0]
  def change
    create_table :sizes do |t|
      t.references :variant, null: false, foreign_key: true
      t.references :product, null: true, foreign_key: true
      t.string :size
      t.string :size_alpha
      t.integer :quantity

      t.timestamps
    end
  end
end