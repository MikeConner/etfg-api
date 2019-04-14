class CreateEsgPooledInstruments < Apiv2MigrationBase[5.2]
  def change
    create_table :esg_pooled_instruments do |t|
      t.integer :pooled_instrument_id, :null => false, :limit => 8
      t.string :composite_ticker, :null => false, :limit => 32
      t.string :exchange_country, :null => false, :limit => 64
      t.date :effective_date
      t.date :expiration_date
      t.string :standard_composite_name, :null => false, :limit => 128
      t.text :composite_name_variants, :null => false
      t.string :composite_description
      t.string :issuer, :limit => 64
      t.boolean :is_index, :null => false, :default => false
      t.boolean :is_active
      t.boolean :is_etn
      t.boolean :is_levered
      t.boolean :is_inverse
      t.boolean :has_derivatives
      t.boolean :options_available
      t.date :inception_date
      t.string :etp_structure_type, :limit => 50
      t.string :category, :limit => 28
      t.string :related_index_symbol, :limit => 16
      t.decimal :net_expenses, :precision => 18, :scale => 6
      t.decimal :expense_ratio, :precision => 18, :scale => 6
      t.string :listing_exchange, :limit => 64
      t.string :asset_class, :limit => 28
      t.string :development_class, :limit => 32
      t.string :focus, :limit => 28
      t.string :lead_market_maker, :limit => 128
      t.string :region, :limit => 28
      t.decimal :levered_amount, :precision => 18, :scale => 6
      t.date :maturity_date
      t.string :exposure_country, :limit => 64
      t.string :selection_criteria, :limit => 32
      t.string :weighting_scheme, :limit => 32
      t.string :administrator, :limit => 128
      t.string :advisor, :limit => 128
      t.string :distributor, :limit => 128
      t.decimal :fee_waivers, :precision => 18, :scale => 6
      t.string :fiscal_year_end, :limit => 16
      t.string :futures_commission_merchant, :limit => 128
      t.string :subadvisor, :limit => 128
      t.string :tax_classification, :limit => 128
      t.string :transfer_agent, :limit => 50
      t.string :trustee, :limit => 128
      t.decimal :creation_fee, :precision => 18, :scale => 6
      t.decimal :creation_unit_size, :precision => 18, :scale => 6
      t.string :custodian, :limit => 128
      t.string :distribution_frequency, :limit => 32
      t.decimal :management_fee, :precision => 18, :scale => 6
      t.string :portfolio_manager
      t.string :primary_benchmark
      t.decimal :total_expenses, :precision => 18, :scale => 6
      t.decimal :other_expenses, :precision => 18, :scale => 6
      t.boolean :approved, :null => false, :default => false
      t.column :figi, 'character(12)'
      t.boolean :is_exchange_figi
      t.column :sedol, 'character(7)'
      t.column :isin, 'character(12)'
      t.column :cusip, 'character(9)'
      t.column :secid, 'character(12)'
      t.integer :datasource_id
    end
  end
end
