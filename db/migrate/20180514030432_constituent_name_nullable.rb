class ConstituentNameNullable < ActiveRecord::Migration[5.2]
  def change
    change_column :constituents, :constituent_name, :string, :null => true
  end
end
