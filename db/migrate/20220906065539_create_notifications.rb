class CreateNotifications < ActiveRecord::Migration[6.1]
  def change
    create_table :notifications do |t|
      t.text :content
      t.boolean :is_read
      t.references :users, foreign_key: true

      t.timestamps
    end
  end
end
