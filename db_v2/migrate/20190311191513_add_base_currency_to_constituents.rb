class AddBaseCurrencyToConstituents < Apiv2MigrationBase[5.2]
  def change
    add_column :constituents, :base_currency, :string, :limit => 16
  end
end
