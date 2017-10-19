class CreatePurchaseDetails < ActiveRecord::Migration[5.0]
  def change
    create_table :purchase_details do |t|
      t.references :purchase, foreign_key: true, null: false
      t.references :item, foreign_key: true, null: false
      t.string :item_name, null: false
      t.integer :price, null: false
      t.integer :quantity, null: false

      t.timestamps
    end
  end
end
