class CreateAddresses < ActiveRecord::Migration[5.0]
  def change
    create_table :addresses do |t|
      t.references :member, foreign_key: true, null: false
      t.boolean :invoice, null: false, default: false
      t.boolean :delivery, null: false, default: true
      t.string :last_name, null: false
      t.string :first_name, null: false
      t.string :postal_code, null: false
      t.integer :prefecture_id, null: false
      t.string :address1, null: false
      t.string :address2
      t.string :phone, null: false

      t.timestamps
    end
  end
end
