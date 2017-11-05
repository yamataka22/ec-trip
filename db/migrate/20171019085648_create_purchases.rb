class CreatePurchases < ActiveRecord::Migration[5.0]
  def change
    create_table :purchases do |t|
      t.references :member, foreign_key: true
      t.integer :item_amount, null: false, default: 0
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
      t.string :guest_email
      t.string :cart_session_id
      t.string :stripe_charge_id, null: false
      t.date :purchased_date, null: false
      t.text :remarks
      t.boolean :delivered, null: false, default: false
      t.datetime :delivered_at

      t.timestamps
    end
  end
end
