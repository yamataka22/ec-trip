class CreateTopics < ActiveRecord::Migration[5.0]
  def change
    create_table :topics do |t|
      t.string :title, null: false
      t.string :link_url

      t.timestamps
    end
  end
end
