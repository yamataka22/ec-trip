class CreateItems < ActiveRecord::Migration[5.0]
  def change
    create_table :items do |t|
      t.string :name, null: false
      t.string :description
      t.integer :caption_image_id
      t.text :about
      t.integer :price
      t.integer :stock_quantity
      t.string :remarks
      t.integer :status, null: false, default: 0
      t.boolean :pickup, null: false, defualt: false
      t.boolean :arrival_new, null: false, default: false

      t.timestamps
    end

    add_foreign_key :items, :images, column: :caption_image_id
  end
end
