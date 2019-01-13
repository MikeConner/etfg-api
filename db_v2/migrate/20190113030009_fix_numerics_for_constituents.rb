class FixNumericsForConstituents < Apiv2MigrationBase[5.2]
  def up
    # Leave analytics alone, since they're filled in from the Analytics engine
    
    change_column :constituents, :weight, :decimal, :precision => 18, :scale => 10
    change_column :constituents, :market_value, :decimal, :precision => 22, :scale => 6
    change_column :constituents, :total_shares_held, :decimal, :precision => 22, :scale => 6
    
    change_column :fund_flows, :shares, :decimal, :precision => 22, :scale => 6
    change_column :fund_flows, :nav, :decimal, :precision => 22, :scale => 6
    change_column :fund_flows, :value, :decimal, :precision => 22, :scale => 6

    change_column :industries, :fund_aum, :decimal, :precision => 22, :scale => 6
    change_column :industries, :creation_unit_size, :decimal, :precision => 22, :scale => 6
    change_column :industries, :creation_fee, :decimal, :precision => 22, :scale => 6
    change_column :industries, :short_interest, :decimal, :precision => 22, :scale => 6
    change_column :industries, :num_constituents, :decimal, :precision => 22, :scale => 6
    change_column :industries, :discount_premium, :decimal, :precision => 22, :scale => 6
    change_column :industries, :bid_ask_spread, :decimal, :precision => 22, :scale => 6
    change_column :industries, :management_fee, :decimal, :precision => 22, :scale => 6
    change_column :industries, :other_expenses, :decimal, :precision => 22, :scale => 6
    change_column :industries, :total_expenses, :decimal, :precision => 22, :scale => 6
    change_column :industries, :fee_waivers, :decimal, :precision => 22, :scale => 6
    change_column :industries, :net_expenses, :decimal, :precision => 22, :scale => 6
  end
  
  def down
    change_column :constituents, :weight, :decimal, :precision => 10, :scale => 6
    change_column :constituents, :market_value, :decimal, :precision => 20, :scale => 6
    change_column :constituents, :total_shares_held, :decimal, :precision => 18, :scale => 4

    change_column :fund_flows, :shares, :decimal, :precision => 14, :scale => 2
    change_column :fund_flows, :nav, :decimal, :precision => 14, :scale => 6
    change_column :fund_flows, :value, :decimal, :precision => 20, :scale => 6

    change_column :industries, :fund_aum, :decimal, :precision => 24, :scale => 6
    change_column :industries, :creation_unit_size, :decimal
    change_column :industries, :creation_fee, :decimal
    change_column :industries, :short_interest, :decimal
    change_column :industries, :num_constituents, :decimal
    change_column :industries, :discount_premium, :decimal
    change_column :industries, :bid_ask_spread, :decimal, :precision => 16, :scale => 12
    change_column :industries, :management_fee, :decimal, :precision => 12, :scale => 4
    change_column :industries, :other_expenses, :decimal, :precision => 12, :scale => 4
    change_column :industries, :total_expenses, :decimal, :precision => 12, :scale => 4
    change_column :industries, :fee_waivers, :decimal, :precision => 12, :scale => 4
    change_column :industries, :net_expenses, :decimal, :precision => 12, :scale => 4
  end
end
