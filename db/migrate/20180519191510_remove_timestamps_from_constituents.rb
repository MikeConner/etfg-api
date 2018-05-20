class RemoveTimestampsFromConstituents < ActiveRecord::Migration[5.2]
  def up
    drop_table :constituents

    #create_table :constituents, :id => false, :primary_key => %i[run_date composite_ticker] do |t|
    create_table :constituents do |t|
      t.date :run_date, :null => false
      t.string :composite_ticker, :limit => 8, :null => false
      t.string :identifier, :limit => 32
      t.string :constituent_name
      t.decimal :weight, :precision => 10, :scale => 6
      t.decimal :market_value, :precision => 20, :scale => 6
      t.string :cusip, :limit => 24
      t.string :isin, :limit => 16
      t.string :figi, :limit => 16
      t.string :sedol, :limit => 16
      t.string :country, :limit => 32
      t.string :exchange, :limit => 16
      t.decimal :total_shares_held, :precision => 18, :scale => 4
      t.string :market_sector, :limit => 128
      t.string :security_type, :limit => 128
    end

    add_index :constituents, :run_date
    add_index :constituents, :composite_ticker
    add_index :constituents, :constituent_name
  end
  
  def down
    drop_table :constituents
    
    create_table :constituents do |t|
      t.date :run_date, :null => false
      t.string :composite_ticker, :limit => 8, :null => false
      t.string :identifier, :limit => 32
      t.string :constituent_name
      t.decimal :weight, :precision => 10, :scale => 6
      t.decimal :market_value, :precision => 20, :scale => 6
      t.string :cusip, :limit => 24
      t.string :isin, :limit => 16
      t.string :figi, :limit => 16
      t.string :sedol, :limit => 16
      t.string :country, :limit => 32
      t.string :exchange, :limit => 16
      t.decimal :total_shares_held, :precision => 18, :scale => 4
      t.string :market_sector, :limit => 128
      t.string :security_type, :limit => 128

      t.timestamps
    end

    add_index :constituents, :run_date
    add_index :constituents, :composite_ticker
    add_index :constituents, :constituent_name
  end
end
