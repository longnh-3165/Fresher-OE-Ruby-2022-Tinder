class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :name
      t.date :date_of_birth
      t.integer :gender
      t.string :email
      t.string :facebook
      t.string :phone
      t.text :description
      t.string :password
      t.boolean :actived
      t.boolean :admin
      t.integer :type
      t.references :countries, foreign_key: true

      t.timestamps
    end
  end
end
