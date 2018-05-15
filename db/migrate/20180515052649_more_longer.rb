class MoreLonger < ActiveRecord::Migration[5.2]
  def up
    change_column :industries, :avg_volume, :string, :limit => 32
    change_column :industries, :category, :string, :limit => 64
    change_column :industries, :focus, :string, :limit => 64   
  end
  
  def down
    change_column :industries, :avg_volume, :string, :limit => 16
    change_column :industries, :category, :string, :limit => 32
    change_column :industries, :focus, :string, :limit => 32    
  end
end
