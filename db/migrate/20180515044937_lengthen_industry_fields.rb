class LengthenIndustryFields < ActiveRecord::Migration[5.2]
  def up
    change_column :industries, :issuer, :string, :limit => 128
    change_column :industries, :related_index, :string
    change_column :industries, :name, :string
    change_column :industries, :tax_classification, :string, :limit => 128
    change_column :industries, :avg_volume, :string, :limit => 16
  end
  
  def down
    change_column :industries, :issuer, :string, :limit => 64
    change_column :industries, :related_index, :string, :limit => 128
    change_column :industries, :name, :string, :limit => 128
    change_column :industries, :tax_classification, :string, :limit => 64   
    change_column :industries, :avg_volume, :string, :limit => 10
  end
end
