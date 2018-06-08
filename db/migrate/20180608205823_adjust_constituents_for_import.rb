class AdjustConstituentsForImport < ActiveRecord::Migration[5.2]
  def up
    change_column :constituents, :composite_ticker, :string, :limit => 12, :null => false
  end
  
  def down
    change_column :constituents, :composite_ticker, :string, :limit => 8, :null => false
  end
end
