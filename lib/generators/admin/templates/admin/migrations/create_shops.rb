class CreateShops < ActiveRecord::Migration[6.0]
  def change
    create_table :shops do |t|
      t.references :user, null: true, foreign_key: true
      t.string :code, null: false
      t.string :name
      t.text :description
      t.string :phone_no
      t.string :contact_email
      t.timestamps
    end
  end
end
