class CreateBaskets < Apiv2MigrationBase[5.2]
  def change
    create_table :baskets do |t|
      t.date :run_date, :null => false
      t.date :as_of_date
      t.string :composite_ticker, :null => false, :limit => 32
      t.string :exchange_country, :null => false, :limit => 16
      t.string :composite_name, :limit => 128
      t.string :issuer, :limit => 32
      t.column :composite_cusip, 'character(9)'
      t.column :composite_isin, 'characteR(12)'
      t.decimal :creation_unit_size, :precision => 18, :scale => 6
      t.decimal :estimated_cash, :precision => 22, :scale => 6
      t.decimal :total_cash, :precision => 22, :scale => 6
      t.decimal :cash_in_lieu_value, :precision => 22, :scale => 6
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
      t.integer :component_count
      t.string :asset_class, :limit => 28
      t.string :category, :limit => 28
      t.string :development_class, :limit => 32
      t.string :focus, :limit => 28
      t.decimal :expense_ratio, :precision => 18, :scale => 6
      t.decimal :aum, :precision => 22, :scale => 6
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
    
    add_index :baskets, :run_date
    add_index :baskets, :composite_ticker
    add_index :baskets, [:run_date, :composite_ticker]
  end
end
