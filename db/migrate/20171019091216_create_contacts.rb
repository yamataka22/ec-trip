class CreateContacts < ActiveRecord::Migration[5.0]
  def change
    create_table :contacts do |t|
      t.text :body, null: false
      t.string :email, null: false
      t.string :last_name, null: false
      t.string :first_name
      t.string :phone
      t.boolean :read, null: false, default: false

      t.timestamps
    end
  end
end
