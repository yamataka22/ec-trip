class CreateCategoryItems < ActiveRecord::Migration[5.0]
  def change
    create_table :category_items do |t|
      t.references :category, foreign_key: true
      t.references :item, foreign_key: true

      t.timestamps
    end
  end
end
