class ChangeDefaultValueColumn < ActiveRecord::Migration[6.1]
  def change
    change_column_default(:users, :admin, false)
    change_column_default(:users, :type_of, 0)
    change_column_default(:relationships, :status, false)
    change_column_default(:messages, :is_read, false)
  end
end
