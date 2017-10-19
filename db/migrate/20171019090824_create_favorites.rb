class CreateFavorites < ActiveRecord::Migration[5.0]
  def change
    create_table :favorites do |t|
      t.references :member, foreign_key: true, null: false
      t.references :item, foreign_key: true, null: false

      t.timestamps
    end
  end
end
