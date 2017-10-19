class CreatePurchages < ActiveRecord::Migration[5.0]
  def change
    create_table :purchages do |t|
      t.references :member, foreign_key: true, null: false
      t.references :credit_card, foreign_key: true, null: false
      t.integer :item_amount, null: false
      t.integer :tax, null: false
      t.integer :delivery_fee, null: false
      t.string :delivery_last_name, null: false
      t.string :delivery_first_name, null: false
      t.string :delivery_phone, null: false
      t.string :delivery_postal_code, null: false
      t.integer :delivery_prefecture_id, null: false
      t.string :delivery_address1, null: false
      t.string :delivery_address2
      t.string :invoice_last_name, null: false
      t.string :invoice_first_name, null: false
      t.string :invoice_phone, null: false
      t.string :invoice_postal_code, null: false
      t.integer :invoice_prefecture_id, null: false
      t.string :invoice_address1, null: false
      t.string :invoice_address2
      t.string :stripe_payment_id

      t.timestamps
    end
  end
end
