class AddCountryToFundFlows < Apiv2MigrationBase[5.2]
  def change
    add_column :fund_flows, :region, 'character(2)'
  end
end
