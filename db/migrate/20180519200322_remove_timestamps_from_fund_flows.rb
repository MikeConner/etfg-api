class RemoveTimestampsFromFundFlows < ActiveRecord::Migration[5.2]
  def up
    drop_table :fund_flows

    #create_table :fund_flows, :id => false, :primary_key => %i[run_date composite_ticker] do |t|
    create_table :fund_flows do |t|
      t.date :run_date, :null => false
      t.string :composite_ticker, :limit => 8, :null => false
      t.decimal :shares, :precision => 14, :scale => 2
      t.decimal :nav, :precision => 14, :scale => 6
      t.decimal :value, :precision => 20, :scale => 6
    end
    
    add_index :fund_flows, [:run_date, :composite_ticker], :unique => true
    add_index :fund_flows, :run_date
    add_index :fund_flows, :composite_ticker
  end
  
  def down
    drop_table :fund_flows
    
    create_table :fund_flows do |t|
      t.date :run_date, :null => false
      t.string :composite_ticker, :limit => 8, :null => false
      t.decimal :shares, :precision => 14, :scale => 2
      t.decimal :nav, :precision => 14, :scale => 6
      t.decimal :value, :precision => 20, :scale => 6

      t.timestamps
    end
    
    add_index :fund_flows, [:run_date, :composite_ticker], :unique => true
    add_index :fund_flows, :run_date
    add_index :fund_flows, :composite_ticker
  end
end
