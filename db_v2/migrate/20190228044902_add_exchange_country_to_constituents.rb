class AddExchangeCountryToConstituents < Apiv2MigrationBase[5.2]
  def change
    add_column :constituents, :region, 'character(2)'
  end
end
