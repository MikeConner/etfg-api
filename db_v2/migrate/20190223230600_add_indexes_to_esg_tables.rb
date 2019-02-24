class AddIndexesToEsgTables < Apiv2MigrationBase[5.2]
  def change
    add_index :esg_cores, :etfg_date
    add_index :esg_cores, :isin
    add_index :esg_cores, [:etfg_date, :isin]
    add_index :esg_cores, :region
    add_index :esg_cores, [:etfg_date, :region]
    add_index :esg_cores, :sector
    add_index :esg_cores, [:etfg_date, :sector]
    add_index :esg_cores, :industry
    add_index :esg_cores, [:etfg_date, :industry]
    
    add_index :esg_ratings, :etfg_date
    add_index :esg_ratings, :composite_ticker
    add_index :esg_ratings, [:etfg_date, :composite_ticker]
  end
end
