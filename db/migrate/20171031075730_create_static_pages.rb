class CreateStaticPages < ActiveRecord::Migration[5.0]
  def change
    create_table :static_pages do |t|
      t.string :name, null: false, index: {unique: true}
      t.string :title, null: false
      t.text :content, null: false
      t.boolean :published, null: false, default: false

      t.timestamps
    end
  end
end
