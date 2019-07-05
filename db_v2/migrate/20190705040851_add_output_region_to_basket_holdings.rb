class AddOutputRegionToBasketHoldings < Apiv2MigrationBase[5.2]
  def change
    add_column :basket_holdings, :output_region, 'character(2)'
  end
end
