class AllowNullCountryBasketHoldings < Apiv2MigrationBase[5.2]
  def up
    change_column :basket_holdings, :exchange_country, :string, :limit => 16, :null => true
  end
  
  def down
    change_column :basket_holdings, :exchange_country, :string, :limit => 16, :null => false    
  end
end
