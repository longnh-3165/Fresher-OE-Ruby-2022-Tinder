class CreateMessages < ActiveRecord::Migration[6.1]
  def change
    create_table :messages do |t|
      t.text :content
      t.boolean :is_read
      t.references :user_send, foreign_key: {to_table: :users}
      t.references :user_receive, foreign_key: {to_table: :users}

      t.timestamps
    end
  end
end
