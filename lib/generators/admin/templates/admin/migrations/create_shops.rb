class CreateShops < ActiveRecord::Migration[6.0]
  def change
    create_table :shops do |t|
      t.references :user, null: true, foreign_key: true
      t.string :code, null: false
      t.string :name
      t.string :name_color, default: '#000000'
      t.string :header_color, default: '#FFFFFF'
      t.string :sidebar_color, default: '#FFFFFF'
      t.string :sidebar_content_color, default: '#9E9E9E'
      t.string :sidebar_content_hover_color, default: '#FF8717'
      t.text   :description
      t.string :phone_no
      t.string :contact_email
      t.timestamps
    end
  end
end
