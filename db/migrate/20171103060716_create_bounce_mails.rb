class CreateBounceMails < ActiveRecord::Migration[5.0]
  def change
    create_table :bounce_mails do |t|
      t.string :email

      t.timestamps
    end
  end
end
