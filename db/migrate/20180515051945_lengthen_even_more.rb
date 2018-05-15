class LengthenEvenMore < ActiveRecord::Migration[5.2]
  def up
    change_column :industries, :issuer, :string
    change_column :industries, :tax_classification, :string
  end
  
  def down
    change_column :industries, :issuer, :string, :limit => 128
    change_column :industries, :tax_classification, :string, :limit => 128  
  end
end
