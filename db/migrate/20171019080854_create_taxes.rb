class CreateTaxes < ActiveRecord::Migration[5.0]
  def change
    create_table :taxes do |t|
      t.integer :rate
      t.date :start_date

      t.timestamps
    end
  end
end
