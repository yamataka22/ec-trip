class CreateCarts < ActiveRecord::Migration[5.0]
  def change
    create_table :carts do |t|
      t.references :member, foreign_key: true
      t.string :session_id
      t.references :item, foreign_key: true, null: false
      t.integer :quantity, null: false, default: 0

      t.timestamps
    end
  end
end
