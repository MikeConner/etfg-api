class CreateConstituents < ActiveRecord::Migration[5.2]
  def change
    create_table :constituents do |t|
      t.date :run_date, :null => false
      t.string :composite_ticker, :limit => 8, :null => false
      t.string :identifier, :limit => 32
      t.string :constituent_name, :null => false
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
  end
end
