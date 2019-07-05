class CreateBasketFunds < Apiv2MigrationBase[5.2]
  def change
    create_table :basket_funds do |t|
      t.date :run_date, :null => false
      t.date :as_of_date
      t.string :composite_ticker, :null => false, :limit => 32
      t.string :exchange_country, :null => false, :limit => 16
      t.string :composite_name, :limit => 128
      t.string :issuer, :limit => 32
      t.column :composite_cusip, 'character(9)'
      t.column :composite_isin, 'characteR(12)'
      t.decimal :creation_fee, :precision => 18, :scale => 6
      t.decimal :creation_unit_size, :precision => 18, :scale => 6
      t.boolean :cash_only_flag
      t.decimal :estimated_cash_cu, :precision => 22, :scale => 6
      t.decimal :estimated_cash_etf, :precision => 22, :scale => 6
      t.decimal :total_cash, :precision => 22, :scale => 6
      t.decimal :cash_in_lieu_value, :precision => 22, :scale => 6
      t.decimal :dividend_per_etf, :precision => 22, :scale => 6
      t.integer :component_count
      t.string :asset_class, :limit => 28
      t.string :category, :limit => 28
      t.string :development_class, :limit => 32
      t.string :focus, :limit => 28
      t.decimal :expense_ratio, :precision => 18, :scale => 6
      t.decimal :aum, :precision => 22, :scale => 6
      t.decimal :nav_per_cu, :precision => 22, :scale => 6
      t.decimal :nav, :precision => 22, :scale => 6
      t.decimal :shares_outstanding, :precision => 22, :scale => 6
      t.text :geographic_exposure
      t.text :sector_exposure
      t.text :industry_exposure
      t.text :industry_group_exposure
      t.text :subindustry_exposure
      t.decimal :reward_score, :precision => 16, :scale => 4
      t.decimal :risk_total_score, :precision => 16, :scale => 4
      t.column :output_region, 'character(2)'
    end
    
    add_index :basket_funds, :run_date
    add_index :basket_funds, :composite_ticker
    add_index :basket_funds, [:run_date, :composite_ticker]
  end
end
