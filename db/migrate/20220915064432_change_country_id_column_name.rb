class ChangeCountryIdColumnName < ActiveRecord::Migration[6.1]
  def change
    rename_column(:users, :countries_id, :country_id)
  end
end
