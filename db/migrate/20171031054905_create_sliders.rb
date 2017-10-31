class CreateSliders < ActiveRecord::Migration[5.0]
  def change
    create_table :sliders do |t|
      t.string :title
      t.string :description
      t.text :link_url
      t.references :image, foreign_key: true
      t.integer :caption_position, null: false, default: 0
      t.integer :caption_color, null: false, default: 0
      t.boolean :published

      t.timestamps
    end
  end
end
