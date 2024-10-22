class CreateVariants < ActiveRecord::Migration[6.0]
  def change
    create_table :variants do |t|
      t.references :product, null: false, foreign_key: true
      t.string :name
      t.string :color

      t.timestamps
    end
  end
end