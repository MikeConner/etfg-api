class AddExchangeCountryToFundFlows < Apiv2MigrationBase[5.2]
  def change
    add_column :fund_flows, :country, 'character(2)'
  end
end
