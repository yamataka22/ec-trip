class CreatePreviews < ActiveRecord::Migration[5.0]
  def change
    create_table :previews do |t|
      t.text :content

      t.timestamps
    end
  end
end
