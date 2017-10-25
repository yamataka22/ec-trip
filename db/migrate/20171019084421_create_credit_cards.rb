class CreateCreditCards < ActiveRecord::Migration[5.0]
  def change
    create_table :credit_cards do |t|
      t.references :member, foreign_key: true, null: false
      t.string :stripe_card_id, null: false, unique: true
      t.string :brand, null: false
      t.string :last4, null: false
      t.string :exp_month, null: false
      t.string :exp_year, null: false
      t.string :name, null: false
      t.boolean :main, null: false, default: false

      t.timestamps
    end
  end
end
