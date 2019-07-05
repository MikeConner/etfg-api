class CreateBasketHoldings < Apiv2MigrationBase[5.2]
  def change
    create_table :basket_holdings do |t|
      t.date :run_date, :null => false
      t.date :as_of_date
      t.string :composite_ticker, :null => false, :limit => 32
      t.string :exchange_country, :null => false, :limit => 16
      t.string :composite_name, :limit => 128
      t.string :issuer, :limit => 32
      t.string :constituent_ticker, :limit => 64
      t.string :constituent_name, :limit => 128
      t.column :cusip, 'character(9)'
      t.column :figi, 'character(12)'
      t.column :isin, 'character(12)'
      t.column :sedol, 'character(7)'
      t.decimal :market_value, :precision => 22, :scale => 6
      t.decimal :basket_weight, :precision => 18, :scale => 10
      t.decimal :holdings_weight, :precision => 18, :scale => 10
      t.decimal :weight_diff, :precision => 18, :scale => 10
      t.decimal :total_shares_held, :precision => 22, :scale => 6
      t.boolean :cash_in_lieu_flag
      t.boolean :new_security_flag
    end
    
    add_index :basket_holdings, :run_date
    add_index :basket_holdings, :composite_ticker
    add_index :basket_holdings, [:run_date, :composite_ticker]
    add_index :basket_holdings, :constituent_ticker
    add_index :basket_holdings, [:run_date, :constituent_ticker]
  end
end
