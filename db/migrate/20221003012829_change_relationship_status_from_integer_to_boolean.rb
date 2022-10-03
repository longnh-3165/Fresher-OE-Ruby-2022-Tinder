class ChangeRelationshipStatusFromIntegerToBoolean < ActiveRecord::Migration[6.1]
  def change
    change_column :relationships, :status, :boolean
  end
end
