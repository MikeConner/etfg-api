class CreateEsgInstruments < Apiv2MigrationBase[5.2]
  def change
    create_table :esg_instruments do |t|
      t.integer :instrument_id, :null => false, :limit => 8
      t.date :effective_date
      t.date :expiration_date
      t.string :ticker, :limit => 64
      t.string :exchange_country, :limit => 64
      t.string :currency, :limit => 16
      t.string :standard_name, :limit => 128
      t.text :name_variants
      t.column :figi, 'character(12)'
      t.boolean :is_exchange_figi
      t.column :sedol, 'character(7)'
      t.column :isin, 'character(12)'
      t.column :cusip, 'character(9)'
      t.column :secid, 'character(12)'
      t.string :cusip_validated, :limit => 16
      t.string :exchange, :limit => 64
      t.string :market_sector, :limit => 128
      t.string :security_type, :limit => 128
      t.string :sector, :limit => 64
      t.string :industry, :limit => 64
      t.string :industry_group, :limit => 128
      t.string :subindustry, :limit => 128
      t.string :rating, :limit => 32
      t.string :geography, :limit => 3
      t.string :asset_class, :limit => 128
      t.integer :datasource_id
      t.boolean :approved, :null => false, :default => false
      t.boolean :is_valid, :null => false, :default => false
      t.boolean :default_instrument, :null => false, :default => false
      t.text :notes
    end
  end
end
