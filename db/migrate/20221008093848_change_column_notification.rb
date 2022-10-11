class ChangeColumnNotification < ActiveRecord::Migration[6.1]
  def change
    rename_column(:notifications, :users_id, :user_send_id)
    add_column :notifications, :user_receive_id, :integer
  end
end
