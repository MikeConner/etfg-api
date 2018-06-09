class UniformTickerLengths < ActiveRecord::Migration[5.2]
  def up
    change_column :analytics, :composite_ticker, :string, :limit => 12, :null => false
    change_column :industries, :composite_ticker, :string, :limit => 12, :null => false
    change_column :fund_flows, :composite_ticker, :string, :limit => 12, :null => false
  end
  
  def down
    change_column :analytics, :composite_ticker, :string, :limit => 8, :null => false
    change_column :industries, :composite_ticker, :string, :null => false
    change_column :fund_flows, :composite_ticker, :string, :limit => 8, :null => false    
  end
end
