class CreateTopics < ActiveRecord::Migration[5.0]
  def change
    create_table :topics do |t|
      t.string :text, null: false
      t.string :link

      t.timestamps
    end
  end
end
