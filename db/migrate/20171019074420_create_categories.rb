class CreateCategories < ActiveRecord::Migration[5.0]
  def change
    create_table :categories do |t|
      t.string :name, null: false
      t.integer :root_category_id
      t.integer :sequence, null: false, default: 0

      t.timestamps
    end
  end
end
