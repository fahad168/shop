class CreateSizes < ActiveRecord::Migration[6.0]
  def change
    create_table :sizes do |t|
      t.references :variant, null: true, foreign_key: true
      t.string :name
      t.string :short_form
      t.integer :in_stock

      t.timestamps
    end
  end
end